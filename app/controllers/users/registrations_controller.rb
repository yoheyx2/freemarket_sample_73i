# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  def new
    @user = User.new
    @user.addresses.build
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      sign_in(:user, @user)
      redirect_to root_path
    else
      render :new
    end

  end
  private
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname, :email, :password, :first_name, :last_name, :first_name_furigana, :last_name_furigana, :password_confirmation, :date_of_bith, addresses_attributes: [:postal_code, :prefecture_id, :city, :address, :other, :first_name, :first_name_furigana, :last_name, :last_name_furigana, :phone_nember]])
  end
  def user_params
    params.require(:user).permit(:nickname, :email, :password, :first_name, :last_name, :first_name_furigana, :last_name_furigana, :password_confirmation, :date_of_birth, addresses_attributes: [:postal_code, :prefecture_id, :city, :address, :other, :first_name, :first_name_furigana, :last_name, :last_name_furigana, :phone_number])
  end
end