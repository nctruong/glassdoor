class Applicant < ApplicationRecord
  belongs_to :user
  has_many :job_applications
  has_many :cvs, class_name: 'Cv'

  validates :email, presence: true, uniqueness: true
end
