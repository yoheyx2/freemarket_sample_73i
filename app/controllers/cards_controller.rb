class CardsController < ApplicationController
  def new
    @card = Card.new
  end

  def show
    @default_card_information = {number: "4242424242424242", exp_month: "12", exp_year: "2020"}
  end
end
