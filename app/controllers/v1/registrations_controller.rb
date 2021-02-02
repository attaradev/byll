# frozen_string_literal: true

module V1
  class RegistrationsController < Devise::RegistrationsController
    before_action :sanitize_params
    def create
      user = User.new(sign_up_params)

      byebug

      if user.save
        token = user.generate_jwt
        render json: token.to_json
      else
        render json: { errors: { 'email or password' => ['is invalid'] } }, status: :unprocessable_entity
      end
    end

    private

    def sign_up_params
      {email: params[:email], password: params[:password], role: params[:role]}
    end

    def sanitize_params
      devise_parameter_sanitizer.sanitize(:sign_up)
    end
  end
end
