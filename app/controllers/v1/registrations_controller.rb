# frozen_string_literal: true

class V1::RegistrationsController < Devise::RegistrationsController
  before_action :sanitize_params
  def create
    if email_exists?
      render json: { errors: { email: 'email already taken' } }, status: :unprocessable_entity
    else
      user = User.create(sign_up_params)
      if user.valid?
        token = user.generate_jwt
        render json: token.to_json
      else
        render json: { errors: { 'email or password' => ['is invalid'] } }, status: :unprocessable_entity
      end
    end
  end

  private

  def email_exists?
    user = User.find_by(email: params[:email])
    !user.nil?
  end

  def sanitize_params
    devise_parameter_sanitizer.sanitize(:sign_up)
  end

  def sign_up_params
    { email: params[:email], password: params[:password], role: params[:role] }
  end
end
