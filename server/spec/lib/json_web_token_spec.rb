require 'rails_helper'

RSpec.describe JsonWebToken do
  let(:payload) { { user_id: 1 } }

  describe '.encode' do
    it 'returns a JWT token' do
      token = described_class.encode(payload)
      expect(token).to be_a(String)
    end
  end

  describe '.decode' do
    context 'with valid token' do
      it 'decodes the JWT token correctly' do
        token = described_class.encode(payload)
        decoded = described_class.decode(token)
        expect(decoded[:user_id]).to eq(1)
      end
    end

    context 'with invalid token' do
      it 'returns nil' do
        expect(described_class.decode('invalid.token.here')).to be_nil
      end
    end
  end
end