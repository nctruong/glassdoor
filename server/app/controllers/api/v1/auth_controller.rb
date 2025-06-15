class Api::V1::AuthController < Api::V1::ApplicationController
  skip_before_action :authenticate_request, only: %w(login)
  def login
    user = User.find_by(email: params[:email])

    if user&.valid_password?(params[:password])
      token = JsonWebToken.encode(user_id: user.id)
      render json: { jwt: token, current_user: user.to_json(only: [ :email, :fullname, :title, :role, :phone ]) }, status: :ok
    else
      raise InvalidLogin
      # render json: { errors: [ {message: 'Invalid email or password'} ] }, status: :unauthorized
    end
  end
end
