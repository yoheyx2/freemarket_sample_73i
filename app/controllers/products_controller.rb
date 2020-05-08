class ProductsController < ApplicationController
  def index
    @products = Product.includes(:product_images)
  end

  def show
    @product = Product.find(params[:id])
  end

  def edit
    @product = Product.find(params[:id])
  end


  def new
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

  
  private
  def product_params
    params.require(:product).permit(:name, :infomation, :brand, :status, :delivery_fee, :ship_form, :delivery_time, :price, :category_id, :situation, product_images_attributes: [:image] ).merge(user_id: current_user.id)
  end

end
