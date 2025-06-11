class Applicant < ApplicationRecord
  belongs_to :user
  has_many :applications, class_name: 'JobApplication'
  has_many :cvs, class_name: 'Cv'

  validates :email, presence: true, uniqueness: true
end
