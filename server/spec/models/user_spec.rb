require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'devise modules' do
    it 'includes Devise modules' do
      expect(User.ancestors).to include(Devise::Models::DatabaseAuthenticatable)
      expect(User.ancestors).to include(Devise::Models::Registerable)
      expect(User.ancestors).to include(Devise::Models::Recoverable)
      expect(User.ancestors).to include(Devise::Models::Rememberable)
      expect(User.ancestors).to include(Devise::Models::Validatable)
    end
  end

  describe 'associations' do
    it { should have_one(:applicant) }
    it { should have_many(:job_applications).through(:applicant) }
    it { should have_many(:cvs).through(:applicant) }
    it { should belong_to(:employer).optional }
  end

  describe 'validations' do
    it { should validate_length_of(:fullname).is_at_most(50).with_long_message('Too many characters') }
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email).case_insensitive }
  end
end