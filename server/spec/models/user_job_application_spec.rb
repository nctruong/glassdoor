require 'rails_helper'

RSpec.describe UserJobApplication, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:job_application) }
  end
end