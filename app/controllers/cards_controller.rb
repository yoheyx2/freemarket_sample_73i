class CardsController < ApplicationController
  require 'payjp'

  def new
    @card = Card.where(user_id: current_user.id)
    redirect_to card_path(current_user.id) if @card.exists?
  end

  def create
    Payjp.api_key = Rails.application.credentials.payjp[:PAYJP_PRIVATE_KEY]
    if params["payjp_token"].blank?
      redirect_to action: "new", alert: "クレジットカードを登録できませんでした"
    else
      customer = Payjp::Customer.create(
        card: params["payjp_token"],
        metadata: {user_id: current_user.id}
      )
      @card = Card.new(user_id: current_user.id, customer_id: customer.id, card_id: customer.default_card)
      if @card.save
        redirect_to users_path
      else
        redirect_to action: "create"
      end
    end
  end

  def show
    @card = Card.find_by(user_id: current_user.id)
    if @card.blank?
      redirect_to action: "new" 
    else
      Payjp.api_key = Rails.application.credentials.payjp[:PAYJP_PRIVATE_KEY]
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
  end

  def destroy
    @card = Card.find_by(user_id: current_user.id)
    if @card.blank?
      redirect_to action: "new"
    else
      Payjp.api_key = Rails.application.credentials.payjp[:PAYJP_PRIVATE_KEY]
      customer = Payjp::Customer.retrieve(@card.customer_id)
      customer.delete
      @card.delete
      if @card.destroy
        redirect_to users_path
      else
        redirect_to card_path(current_user.id), alert: "削除できませんでした。"
      end
    end
  end
end
