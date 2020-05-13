require 'rails_helper'
describe Card do
  describe '#create' do

    context '登録できる場合' do
      it "user_idとcustomer_idとcard_idがある場合は登録できること" do
        card = build(:card)
        expect(card).to be_valid
      end
    end

    context '登録できない場合' do
      it "user_idがない場合は登録できないこと" do
        card = build(:card, user_id: nil)
        card.valid?
        expect(card.errors[:user_id]).to include("can't be blank")
      end

      it "customer_idがない場合は登録できないこと" do
        card = build(:card, customer_id: nil)
        card.valid?
        expect(card.errors[:customer_id]).to include("can't be blank")
      end

      it "card_idがない場合は登録できないこと" do
        card = build(:card, card_id: nil)
        card.valid?
        expect(card.errors[:card_id]).to include("can't be blank")
      end
    end
  end
end