require 'rails_helper'

RSpec.describe Applicant, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
    it { should have_many(:job_applications) }
    # it { should have_many(:cv).class_name('Cv') }
  end

  describe 'validations' do
    let(:user) { create(:user) }
    subject { FactoryBot.create(:applicant, user: user) } # required for uniqueness validation

    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email) }
  end
end