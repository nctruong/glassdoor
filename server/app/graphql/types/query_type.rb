# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject

    field :users, resolver: Resolvers::UserList
    field :jobs, resolver: Resolvers::JobList

  end
end
