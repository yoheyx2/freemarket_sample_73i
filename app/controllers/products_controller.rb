class ProductsController < ApplicationController

  before_action :set_product, only: [:edit, :show, :purchase, :payment]

  def index
    @products = Product.includes(:product_images)
  end

  def show
    @product = Product.find(params[:id])
    ids = Product.includes(:product_images).ids
      if ids.include?(@product.id - 1)
        @previous = @product.id - 1
      else
        @previous = @product.id
      end
      if ids.include?(@product.id + 1)
        @next =  @product.id + 1
      else
        @next =  @product.id
      end
  end

  def edit
  end

  def new
    redirect_to new_user_session_path unless user_signed_in?
    @product = Product.new
    @product.product_images.build
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to root_path
    else
      render :new
    end
  end

  def purchase
    @product = Product.find(params[:id])
    if user_signed_in?
      @user = current_user
      if @user.card.present?
        Payjp.api_key = Rails.application.credentials.payjp[:PAYJP_PRIVATE_KEY]
        @card = Card.find_by(user_id: current_user.id)
        customer = Payjp::Customer.retrieve(@card.customer_id)
        @customer_card = customer.cards.retrieve(@card.card_id)
        @card_brand = @customer_card.brand
        case @card_brand
        when "Visa"
          @card_src = "/visa-logo.png"
        when "JCB"
          @card_src = "/JCB.png"
        when "MasterCard"
          @card_src = "/mastercard.jpg"
        when "American Express"
          @card_src = "/Amex.jpg"
        when "Diners Club"
          @card_src = "/dinners.png"
        when "Discover"
          @card_src = "/discovercard.jpg"
        end
        @exp_month = @customer_card.exp_month.to_s
        @exp_year = @customer_card.exp_year.to_s.slice(2,3)
      end
    else
      redirect_to user_session_path
    end
  end

  def payment
    unless @product.situation == 0
      @card = Card.find_by(user_id: current_user.id)
      @product.situation = 0
      @product.save!
      Payjp.api_key = Rails.application.credentials.payjp[:PAYJP_PRIVATE_KEY]
      charge = Payjp::Charge.create(
      amount: @product.price,
      customer: Payjp::Customer.retrieve(@card.customer_id),
      currency: 'jpy'
      )
    else
      redirect_to product_path
    end
  end

  def set_parents
    @parents  = Category.where(ancestry: nil)
  end

  def set_children
    @children = Category.where(ancestry: params[:parent_id])
  end

  def set_grandchildren
    @grandchildren = Category.where(ancestry: params[:ancestry])
  end

  def set_product
    @product = Product.find(params[:id])
  end

  private
  def product_params
    params.require(:product).permit(:name, :infomation, :brand, :status, :delivery_fee, :ship_form, :delivery_time, :price, :category_id, :situation, product_images_attributes: [:image] ).merge(user_id: current_user.id)
  end

end
