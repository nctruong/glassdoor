module Resolvers
  class JobApplicationCollection < BaseResolver
    type Types::JobApplicationCollectionType, null: true

    argument :params, Types::JobApplicationFilterParams, required: true

    def resolve(params:)
      # retrieved by "object" in type, in order to create nested collection instead returning a list
      {
        params:  params.to_h,
      }
    end
  end
end
