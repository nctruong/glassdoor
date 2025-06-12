require 'rails_helper'

RSpec.describe Employer, type: :model do
  describe 'associations' do
    it { should have_many(:jobs) }
    it { should have_many(:employees) }
  end

  describe 'validations' do
    it { should validate_uniqueness_of(:name).case_insensitive }

    it 'validates email format using custom email validator' do
      employer = described_class.new(email: 'invalid_email')
      employer.validate
      expect(employer.errors[:email]).to be_present
    end

    it 'allows a valid email' do
      employer = described_class.new(email: 'valid@example.com')
      employer.validate
      expect(employer.errors[:email]).to be_empty
    end

    it { should validate_length_of(:short_description).is_at_most(100).with_message('Limit 100 characters') }

    it 'validates long_description using custom visible_text_length validator' do
      long_text = 'a' * 1201
      employer = described_class.new(long_description: long_text)
      employer.validate
      expect(employer.errors[:long_description]).to be_present
    end
  end
end