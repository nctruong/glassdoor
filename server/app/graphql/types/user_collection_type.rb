module Types
  class UserCollectionType < Types::BaseObject
    field :data, [Types::UserType], null: false
    field :page, Integer, null: false
    field :total, Integer, null: false

    def self.authorized?(object, context)
      super && true
    end

    def data
      object[:users]
    end

    def total
      object[:total]
    end

    def page
      object[:page]
    end
  end
end
