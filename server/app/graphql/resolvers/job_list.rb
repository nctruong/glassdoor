module Resolvers
  class JobList < BaseResolver
    type [Types::JobType], null: true

    argument :page_index, Int, required: false, default_value: 1
    argument :page_size, Int, required: false, default_value: 20
    argument :params, Types::JobFilterParams, required: false, default_value: {}
    argument :ids, [String], required: false, default_value: []

    def resolve(page_index:, page_size:, params:, ids:)
      jobs = Job.where(id: ids).limit(page_size) if ids.present?
      jobs ||= Job.page(page_index).per(page_size)
      jobs
    end
  end
end
