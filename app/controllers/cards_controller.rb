class CardsController < ApplicationController
  def new
    @card = Card.new
    card = Card.where(user_id: current_user.id)
    if card.exists?
      redirect_to card_path(card[0].id)
    end
  end

  def create
    Payjp.api_key = ENV['PAYJP_PRIVATE_KEY']
    token = Payjp::Token.create({
      card: {
        number:     params[:card][:number],
        cvc:        params[:card][:cvc],
        exp_month:  params[:card][:exp_month],
        exp_year:   params[:card][:exp_year]
      }},
      {'X-Payjp-Direct-Token-Generate': 'true'} 
    )
    if token.blank?
      redirect_to new_card_path
    else
      customer = Payjp::Customer.create(card: token)
      card = Card.new(user_id: current_user.id, customer_id: customer.id, card_id: customer.default_card)
      card.save!
      if card.save!
        redirect_to card_path(card)
      else
        redirect_to new_card_path
      end
    end
  end

  def show
    card = Card.find_by(user_id: current_user.id)
    if card.blank?
      redirect_to action: "create"
    else
      Payjp.api_key = ENV['PAYJP_PRIVATE_KEY']
      customer = Payjp::Customer.retrieve(card.customer_id)
      @default_card_information = Payjp::Customer.retrieve(card.customer_id).cards.data[0]
    end
  end

  def delete
    card = Card.where(user_id: current_user.id).first
    if card.blank?
    else
      Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
      customer = Payjp::Customer.retrieve(card.customer_id)
      customer.delete
      card.delete
    end
      redirect_to action: "new"
  end
end
