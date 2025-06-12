# An alternative model of applicant, in order to be used in matching logic. Separating relation concern
class Candidate < ApplicationRecord
  belongs_to :cv, class_name: 'Cv', foreign_key: 'latest_cv_id'

  validates :fullname, presence: true
  validates :email, presence: true, uniqueness: true
end
