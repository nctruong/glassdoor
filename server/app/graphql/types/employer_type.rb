module Types
  class EmployerType < Types::BaseObject
    include ActionView::Helpers::TranslationHelper
    include Rails.application.routes.url_helpers
    graphql_name 'Employer'
    delegate :avg_page_views, :views_last_30_days, :ranking_employer, :total_employers, to: :dashboard

    field :id, ID, null: false
    field :name, String, null: false
    field :email, String, null: false

  end
end
