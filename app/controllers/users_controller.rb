class UsersController < ApplicationController
  def index
    @contents = ["マイページ","お知らせ","いいね！一覧","出品する","出品した商品","購入した商品"]
    @settings = ["プロフィール","支払い方法","メール/パスワード","本人情報","ログアウト"]
    @product_quantity = Product.where(user_id: current_user.id).count
  end
end