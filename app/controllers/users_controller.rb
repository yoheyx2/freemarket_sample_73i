class UsersController < ApplicationController
  def index
    @contents = [{name:"マイページ",path: "/users",pattern: "GET"},{name:"お知らせ",path: "",pattern: ""},{name:"いいね一覧",path: "",pattern: ""},{name:"出品する",path: "/products/new",pattern: "GET"},{name:"出品した商品",path: "",pattern: ""},{name:"購入した商品",path: "",pattern: ""}]
    @settings = [{name:"プロフィール",path: "",pattern: ""},{name:"支払方法",path: "/cards/new",pattern: "GET"},{name:"メール/パスワード",path: "",pattern: ""},{name:"本人情報",path: "",pattern: ""},{name:"ログアウト",path: "/users/sign_out",pattern: "DELETE"}]
    @product_quantity = Product.where(user_id: current_user.id).count
  end
end