# frozen_string_literal: true

class V1::SessionsController < Devise::RegistrationsController
  before_action :sanitize_params
  
  def create
    user = User.find_by(email: sign_in_params[:email])

    if user&.valid_password?(sign_in_params[:password])
      token = user.generate_jwt
      render json: token.to_json
    else
      render json: { errors: { 'email or password' => ['is invalid'] } }, status: :unprocessable_entity
    end
  end

  private

  def sign_in_params
    {email: params[:email], password: params[:password]}
  end

  def sanitize_params
    devise_parameter_sanitizer.sanitize(:sign_in)
  end
end
