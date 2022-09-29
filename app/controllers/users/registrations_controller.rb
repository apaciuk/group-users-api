# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  respond_to :json

private

 def respond_with(resource, _opts = {})
    if resource.persisted?
      render json: {
        status: {code: 200, message: 'Woot,Signed up sucessfully.'},
        data: UserSerializer.new(resource).serializable_hash[:data][:attributes]
      }
    else
      render json: {
        status: {message: "User couldn't be created successfully. #{resource.errors.full_messages.to_sentence}"}
      }, status: :unprocessable_entity
    end
 end

protected 

 def configure_sign_up_params 
  devise_parameter_sanitizer.permit(:sign_up, keys: [ :id, :username, :email, :password, :password_confirmation])
 end
 
end

