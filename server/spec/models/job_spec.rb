require 'rails_helper'

RSpec.describe Job, type: :model do
  describe 'associations' do
    it { should belong_to(:employer).touch(true) }
    it { should have_many(:job_applications) }
    it { should have_many(:job_candidates) }
    it { should have_many(:candidates).through(:job_candidates) }
  end

  describe 'delegations' do
    it { should delegate_method(:name).to(:employer).with_prefix(:employer).allow_nil }
  end
end