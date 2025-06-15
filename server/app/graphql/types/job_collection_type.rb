module Types
  class JobCollectionType < Types::BaseObject
    field :jobs, [JobType], null: false
    field :total, Integer, null: false
    field :page, Integer, null: false
    field :page_size, Integer, null: false

    def self.authorized?(object, context)
      true
    end

  end
end
