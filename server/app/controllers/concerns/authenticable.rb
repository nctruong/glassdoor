module Authenticable
  extend ActiveSupport::Concern

  included do
    before_action :authenticate_request
  end

  def authenticate_request
    header = request.headers['Authorization']
    header = header.split(' ').last if header
    decoded = JsonWebToken.decode(header)

   if decoded
     @current_user = User.find(decoded[:user_id])
   else
     raise JWT::DecodeError
   end
  rescue ActiveRecord::RecordNotFound, JWT::DecodeError
    render json: { errors: ['Not Authorized'] }, status: :unauthorized
  end
end