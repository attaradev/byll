# frozen_string_literal: true

class ApplicationController < ActionController::API
  before_action :process_token
  before_action :configure_permitted_parameters, if: :devise_controller?
  respond_to :json

  def authenticate_user!(_options = {})
    head :unauthorized unless signed_in?
  end

  protected

  def current_user
    @current_user = User.find(@current_user_id)
  end

  def finance_team! 
    head :unauthorized unless current_user.role == 'finance_team'
  end

  private

  def process_token
    if request.headers['Authorization'].present?
      begin
        jwt_payload = JWT.decode(request.headers['Authorization'].split(' ')[1].remove('"'), Rails.application.secrets.secret_key_base).first
        @current_user_id = jwt_payload['id']
      rescue JWT::ExpiredSignature, JWT::VerificationError, JWT::DecodeError
        head :unauthorized
      end
    end
  end

  def signed_in?
    @current_user_id.present?
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:role, :email, :password])
    devise_parameter_sanitizer.permit(:sign_in, keys: [:email, :password])
  end
end
