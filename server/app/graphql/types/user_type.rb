module Types
  class UserType < Types::BaseObject
    field :id, Int, null: false
    field :email, String, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :reviews_count, Int, null: false
    field :types, [String], null: false
    field :fullname, String, null: false
    field :phone, String, null: false
    field :title, String, null: true

    def self.authorized?(object, context)
      super && true
    end
  end
end
