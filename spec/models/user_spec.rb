require 'rails_helper'
describe User do
  describe '#create' do
    # userに関して
    it "nickname.email.password.password_confirmation.first_name.first_name_furigana.last_name.last_name_furigana.
    date_of_birth.postal_code.prefecture_id.city.addressが存在すれば登録出来ること" do
      user = build(:user)
      expect(user).to be_valid
  end
    it "nicknameがなければ登録出来ないこと" do
      user = build(:user, nickname: "")
      user.valid?
      expect(user.errors[:nickname]).to include("can't be blank")
    end
    it "emailがなければ登録出来ないこと" do
      user = build(:user, email: "")
      user.valid?
      expect(user.errors[:email]).to include("can't be blank")
    end
    it "passwordがなければ登録出来ないこと" do
      user = build(:user, password: "")
      user.valid?
      expect(user.errors[:password]).to include("can't be blank")
    end
    it "passwordが７文字以上なら登録出来ること" do
        user = build(:user, password: "0000000", password_confirmation: "0000000")
        expect(user).to be_valid
    end
    it " passwordが6文字以下であれば登録できないこと " do
      user = build(:user, password: "000000", password_confirmation: "000000")
      user.valid?
      expect(user.errors[:password]).to include("is too short (minimum is 7 characters)")
    end
    it "fist_nameがなければ登録出来ないこと" do
      user = build(:user, first_name: "")
      user.valid?
      expect(user.errors[:first_name]).to include("can't be blank")
    end
    it "last_nameがなければ登録出来ないこと" do
      user = build(:user, last_name: "")
      user.valid?
      expect(user.errors[:last_name]).to include("can't be blank")
    end
    it "first_name_furiganaがなければ登録出来ないこと" do
      user = build(:user, first_name_furigana: "")
      user.valid?
      expect(user.errors[:first_name_furigana]).to include("can't be blank")
    end
    it "last_name_furiganaがなければ登録出来ないこと" do
      user = build(:user, last_name_furigana: "")
      user.valid?
      expect(user.errors[:last_name_furigana]).to include("can't be blank")
    end
      it "date_of_birthがなければ登録出来ないこと" do
        user = build(:user, date_of_birth: "")
        user.valid?
        expect(user.errors[:date_of_birth]).to include("can't be blank")
      end
    # addressに関して 
    it "postal_codeがなければ登録出来ないこと" do
      user = build(:address, postal_code: "")
      user.valid?
      expect(user.errors[:postal_code]).to include("can't be blank")
    end
    it "prefecture_idがなければ登録e出来ないこと" do
      user = build(:address, prefecture_id: "")
      user.valid?
      expect(user.errors[:prefecture_id]).to include("can't be blank")
    end
    it "cityがなければ登録出来ないこと" do
      user = build(:address, city: "")
      user.valid?
      expect(user.errors[:city]).to include("can't be blank")
    end
    it "addressがなければ登録出来ないこと" do
      user = build(:address, address: "")
      user.valid?
      expect(user.errors[:address]).to include("can't be blank")
    end
    end
  end