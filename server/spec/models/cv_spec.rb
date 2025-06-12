require 'rails_helper'

RSpec.describe Cv, type: :model do
  describe 'associations' do
    it { should belong_to(:applicant) }
    it { should have_many(:job_applications).dependent(:destroy) }
    it { should have_many(:jobs).through(:job_applications) }
  end

  describe 'validations' do
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:status) }
  end

  describe 'enums' do
    it do
      should define_enum_for(:status).with_values(
        pending:       0,
        approved:      1,
        rejected_120:  2,
        rejected_360:  3,
        spam_rejected: 4
      )
    end

    it do
      should define_enum_for(:state).with_values(
        scanned:  0,
        reviewed: 1
      )
    end
  end

  describe 'defaults' do
    it 'has default status as pending' do
      cv = Cv.new
      expect(cv.status).to eq('pending')
    end
  end
end