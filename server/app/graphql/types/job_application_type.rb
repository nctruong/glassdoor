module Types
  class JobApplicationType < Types::BaseObject
    include ActionView::Helpers::TranslationHelper
    include Rails.application.routes.url_helpers

    field :id, Int, null: false
    field :ip_address, String, null: true
    field :fullname, String, null: true
    field :email, String, null: true
    field :job, JobType, null: true
    field :employer, EmployerType, null: true
    field :created_at, String, null: false
    field :submitted_at, String, null: false
    field :applicant, ApplicantType, null: true
    field :error_status, String, null: true

    def ip_address

    end

    def employer
      object.job&.employer
    end

    def created_at
      l(object.created_at, format: :medium_with_time)
    end

    def submitted_at

    end

  end
end
