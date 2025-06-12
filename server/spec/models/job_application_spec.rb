require 'rails_helper'

RSpec.describe JobApplication, type: :model do
  describe 'associations' do
    it { should belong_to(:cv) }
    it { should belong_to(:job) }
    it { should belong_to(:applicant) }

    it { should have_one(:user_job_application).dependent(:destroy) }
  end
end