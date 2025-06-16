module Resolvers
  class JobList < BaseResolver
    type Types::JobCollectionType, null: true

    argument :page_index, Int, required: false, default_value: 1
    argument :page_size, Int, required: false, default_value: 20
    argument :params, Types::JobFilterParams, required: false, default_value: {}
    argument :ids, [String], required: false, default_value: []

    def resolve(page_index:, page_size:, params:, ids:)
      if ids.present?
        jobs = Job.includes(:employer).where(id: ids).limit(page_size)
      elsif params
        jobs = ::JobSearch.call(**params)
      else
        jobs ||= Job.includes(:employer).page(page_index).per(page_size)
      end

      {
        jobs:      jobs,
        total:     Job.count,
        page:      page_index,
        page_size: page_size,
      }
    end
  end
end
