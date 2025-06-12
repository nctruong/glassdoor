module Types
  class JobType < Types::BaseObject
    include ActionView::Helpers::TranslationHelper

    field :id, ID, null: false
    field :title, String, null: false

    field :description, String, null: true
    field :employer, EmployerType, null: true

    field :salary, String, null: false
    field :address, String, null: true
    field :street_name, String, null: true
    field :street_number, String, null: true
    field :second_city, String, null: true
    field :posted_date, GraphQL::Types::ISO8601DateTime, null: false, method: :created_at
    field :slug, String, null: false
    field :type, String, null: false
    field :status, String, null: false


    def self.authorized?(object, context)
      true
    end

    def street_name
      "Hai Ba Trung"
    end

    def employer
      object.employer
    end

    def salary
      object.decorate.formatted_salary
    end

  end
end
