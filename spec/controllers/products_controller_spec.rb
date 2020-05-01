require 'rails_helper'

describe ProductsController do

  describe '#create' do
    let(:params) { { product: :product, product_image: attributes_for(build :product_image) } }
    context '保存に成功した場合' do
      subject {
        post :create,
        params: params
      }

      it 'productとproduct_imageを保存できること' do
        expect{ subject }.to change(Product, :count).by(1)
        expect{ subject }.to change(Product_image, :count).by(1)
      end

    end

    # context '保存に失敗した場合' do
    # end

  end
end