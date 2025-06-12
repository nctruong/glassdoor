class Applicant < ApplicationRecord
  belongs_to :user
  has_many :job_applications
  has_many :cv, class_name: 'Cv', foreign_key: :applicant_id

  validates :email, presence: true, uniqueness: true
end
