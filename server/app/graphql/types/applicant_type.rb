module Types
  class ApplicantType < Types::BaseObject
    include ActionView::Helpers::TranslationHelper

    field :id, Int, null: true
    field :interested_skills, String, null: true
    field :cv_level, String, null: true

    def interested_skills
      %w[JAVA COBOL]
    end

  end
end
