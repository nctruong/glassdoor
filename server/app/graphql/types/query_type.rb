# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject

    field :users, resolver: Resolvers::UserList
    field :jobs, resolver: Resolvers::JobList
    field :job_applications, resolver: Resolvers::JobApplicationCollection

  end
end
