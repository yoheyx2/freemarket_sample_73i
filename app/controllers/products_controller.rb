class ProductsController < ApplicationController
  def index
    @parents = Category.all.order("id ASC")  
    @products = Product.all
  end

  def show
    @parents = Category.all.order("id ASC")  
    @product = Product.find(params[:id])
  end

  def new
    @parents = Category.all.order("id ASC")
    @product = Product.new
    @product.product_images.build
  end

  def create
    Product.create(product_params)
    redirect_to root_path
  end

  def purchase
    @product = Product.find(params[:id])
  end

  private
  def product_params
    params.require(:product).permit(:name, :infomation, :brand, :status, :delivery_fee, :ship_form, :delivery_time, :price, :category_id, :situation, product_images_attributes: [:image] )
    # 「:category」は「:category_id」に変更となる予定
    # ユーザー登録機能実装後は「.merge(user_id: current_user.id)」を記述すること。
  end

end
