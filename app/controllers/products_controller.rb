class ProductsController < ApplicationController
  def index
    @parents = Category.all.order("id ASC")  
  end

  def show
    @parents = Category.all.order("id ASC")  
  end
end
