# spec/models/job_search_spec.rb
require 'rails_helper'

RSpec.describe Job, type: :model do
  before(:all) do
    Job.__elasticsearch__.create_index!(force: true)
  end

  after(:all) do
    Job.__elasticsearch__.delete_index!
  end
  let!(:job) { create(:job, title: 'Elasticsearch Engineer', status: 'open', published_at: Time.current) }

  it 'searches for a job by title' do

    refresh_elasticsearch_index(Job)

    results = Job.search(
      {
        query: {
          match: { title: 'Elasticsearch' }
        }
      }
    ).records.to_a

    expect(results.first&.title).to eq('Elasticsearch Engineer')
  end
end
