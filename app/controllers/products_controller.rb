class ProductsController < ApplicationController

  before_action :set_product, only: [:edit, :show, :purchase, :update, :destroy]

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

  def edit

    @category_parent_array = Category.where(ancestry: nil).pluck(:name)
    grandchild_category = @product.category
    child_category = grandchild_category.parent

    @category_children_array = Category.where(ancestry: child_category.ancestry)
    @category_grandchildren_array = Category.where(ancestry: grandchild_category.ancestry)
    
    
  end

  def update
    if @product.update(update_product_params)
       redirect_to root_path
    else
       render :edit
    end
  end

  def destroy
    if @product.destroy
      redirect_to root_path
    else
      render :edit
    end
  end

  def purchase
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

  def update_product_params
    params.require(:product).permit(:name, :infomation, :brand, :status, :delivery_fee, :ship_form, :delivery_time, :price, :category_id, :situation, product_images_attributes: [:image, :_destroy, :id] ).merge(user_id: current_user.id)
  end

end
