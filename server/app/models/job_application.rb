# User submits CV for a job which is job application
class JobApplication < ApplicationRecord
  include Searchable

  belongs_to :cv
  belongs_to :job
  belongs_to :applicant

  has_one :user_job_application, dependent: :destroy
end
