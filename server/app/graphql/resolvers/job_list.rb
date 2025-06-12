module Resolvers
  class JobList < BaseResolver
    type [Types::JobType], null: true

    argument :page_index, Int, required: false, default_value: 1
    argument :page_size, Int, required: false, default_value: 20
    argument :params, Types::JobFilterParams, required: false, default_value: {}
    argument :ids, [String], required: false, default_value: []

    def resolve(page_index:, page_size:, params:, ids:)
      if ids.present?
        if context[:current_admin].employer?
          return context[:current_admin].employer.jobs.where(id: ids).limit(page_size)
        else
          return Job.where(id: ids).limit(page_size)
        end
      end

      jobs = JobListBuilder.new
        .filtered_jobs_within_scope(admin: context[:current_admin], params: params)
        .page(page_index).per(page_size)
        .includes(:employer)
      jobs
    end
  end
end
