require 'rails_helper'

RSpec.describe JobCandidate, type: :model do
  describe 'associations' do
    it { should belong_to(:job) }
    it { should belong_to(:cv).class_name('Cv') }
    it { should belong_to(:candidate) }
  end

  describe 'enums' do
    it do
      should define_enum_for(:status).with_values(
        pending:   'Pending',
        previewed: 'Previewed',
        viewed:    'Viewed',
        invited:   'Invited',
        accepted:  'Accepted'
      )
    end
  end
end