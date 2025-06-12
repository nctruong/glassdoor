require 'rails_helper'

RSpec.describe Candidate, type: :model do
  describe 'associations' do
    it { should belong_to(:cv).class_name('Cv').with_foreign_key('latest_cv_id') }
  end

  describe 'validations' do
    subject { FactoryBot.create(:candidate) } # needed for uniqueness test

    it { should validate_presence_of(:fullname) }
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email) }
  end
end