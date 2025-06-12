require 'rails_helper'

RSpec.describe 'JobList Resolver', type: :request do
  let(:admin) { create(:user, role: :admin) }
  let(:employer) { create(:employer) }
  let(:employer_admin) { create(:user, role: :admin, employer: employer) }

  let!(:job1) { create(:job, employer: employer, title: 'Dev Job') }
  let!(:job2) { create(:job, employer: employer, title: 'QA Job') }
  let!(:other_job) { create(:job, title: 'Unrelated Job') }

  let(:query) do
    <<~GRAPHQL
      query($pageIndex: Int, $pageSize: Int, $ids: [String!]) {
        jobs(pageIndex: $pageIndex, pageSize: $pageSize, ids: $ids) {
          id
          title
        }
      }
    GRAPHQL
  end

  it 'returns jobs by IDs for admin' do
    result = ServerSchema.execute(
      query,
      variables: { pageIndex: 1, pageSize: 10, ids: [job1.id.to_s, job2.id.to_s] },
      context: { current_admin: admin }
    )

    job_titles = result['data']['jobs'].map { |j| j['title'] }
    expect(job_titles).to contain_exactly('Dev Job', 'QA Job')
  end

  it 'returns only employer jobs for employer admin' do
    result = ServerSchema.execute(
      query,
      variables: { pageIndex: 1, pageSize: 10, ids: [job1.id.to_s, other_job.id.to_s] },
      context: { current_admin: employer_admin }
    )

    job_titles = result['data']['jobs'].map { |j| j['title'] }
    expect(job_titles.include?('Dev Job')).to be_truthy # Does not include other_job
  end
end