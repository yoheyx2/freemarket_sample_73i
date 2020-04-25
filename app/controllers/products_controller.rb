class ProductsController < ApplicationController
  def index
  end

  def show
  end

  def new
    @product = Product.new
  end

  def create
    Product.create(product_params)
    redirect_to root_path
  end

  private
  def product_params
    params.require(:product).permit(:name, :infomation, :brand, :status, :delivery_fee, :ship_form, :delivery_time, :price, :category, product_image_attributes: [:id, :image])
    # 「:category」は「:category_id」に変更となる予定
    # ユーザー登録機能実装後は「.merge(user_id: current_user.id)」を記述すること。
  end

end
