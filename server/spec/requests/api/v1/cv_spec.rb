require 'rails_helper'

RSpec.describe "Api::V1::Cvs", type: :request do
  let(:user) { create(:user, password: "password") }
  let(:token) { JWT.encode({ user_id: user.id}, Rails.application.credentials.secret_key_base)}
  let(:headers) { { 'Authorization' => "Bearer #{token}"}}

  describe "GET /index" do
    it 'returns success' do
      get '/apiService/v1/cvs', headers: headers
      expect(response).to have_http_status(:ok)
    end

    it 'returns error' do
      get '/apiService/v1/cvs'
      expect(response).to have_http_status(401)
    end
  end
end
