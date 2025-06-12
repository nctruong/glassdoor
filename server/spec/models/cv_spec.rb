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
        pending:       'Pending Review',
        approved:      'Approved',
        rejected_120:  '120 Rejected',
        rejected_360:  '360 Rejected',
        spam_rejected: 'Spam Rejected'
      )
    end

    it do
      should define_enum_for(:state).with_values(
        scanned:  'scanned',
        reviewed: 'reviewed'
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