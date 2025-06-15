class Api::V1::ApplicationController < ActionController::API
  include Authenticable

  rescue_from ::ApiError do |e|
    render json: { errors: [ {message: e.message} ] }
  end
end