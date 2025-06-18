module Types
  class UserType < Types::BaseObject
    field :id, Int, null: false
    field :email, String, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :reviews_count, Int, null: false
    field :role, String, null: true
    field :fullname, String, null: true
    field :phone, String, null: true
    field :title, String, null: true

    def self.authorized?(object, context)
      super && true
    end

    def role
      object.role
    end
  end
end
