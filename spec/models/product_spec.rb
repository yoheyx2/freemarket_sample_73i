require 'rails_helper'
describe Product do
  describe '#create' do

    context '出品できる場合' do
      it "productとproduct_imageがある場合は保存できること" do
        expect(build(:product, product_images: [build(:product_image)])).to be_valid
      end
    end

    context '出品できない場合' do
      it "product_imageがない場合は保存できないこと" do
        product = build(:product)
        product.valid?
        expect(product.errors[:product_images]).to include("can't be blank")
      end

      it "nameがない場合は保存できないこと" do
        product = build(:product, name: nil, product_images: [build(:product_image)])
        product.valid?
        expect(product.errors[:name]).to include("can't be blank")
      end

      it "infomationがない場合は保存できないこと" do
        product = build(:product, infomation: nil, product_images: [build(:product_image)])
        product.valid?
        expect(product.errors[:infomation]).to include("can't be blank")
      end

      it "category_idがない場合は保存できないこと" do
        product = build(:product, category_id: nil, product_images: [build(:product_image)])
        product.valid?
        expect(product.errors[:category_id]).to include()
      end

      it "statusがない場合は保存できないこと" do
        product = build(:product, status: nil, product_images: [build(:product_image)])
        product.valid?
        expect(product.errors[:status]).to include()
      end

      it "delivery_feeがない場合は保存できないこと" do
        product = build(:product, delivery_fee: nil, product_images: [build(:product_image)])
        product.valid?
        expect(product.errors[:delivery_fee]).to include()

      end

      it "ship_formがない場合は保存できないこと" do
        product = build(:product, ship_form: nil, product_images: [build(:product_image)])
        product.valid?
        expect(product.errors[:ship_form]).to include()
      end

      it "delivery_timeがない場合は保存できないこと" do
        product = build(:product, delivery_time: nil, product_images: [build(:product_image)])
        product.valid?
        expect(product.errors[:delivery_time]).to include()
      end

      it "priceがない場合は保存できないこと" do
        product = build(:product, price: nil, product_images: [build(:product_image)])
        product.valid?
        expect(product.errors[:price]).to include()
      end

      it "priceが300以下の場合は保存できないこと" do
        product = build(:product, price: "299", product_images: [build(:product_image)])
        product.valid?
        expect(product.errors[:price]).to include()
      end

      it "priceが9,999,999以上の場合は保存できないこと" do
        product = build(:product, price: "10000000", product_images: [build(:product_image)])
        product.valid?
        expect(product.errors[:price]).to include()
      end

    
    end
  end
end