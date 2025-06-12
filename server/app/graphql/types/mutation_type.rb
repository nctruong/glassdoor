# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    field :update_job, mutation: Mutations::UpdateJob
  end
end
