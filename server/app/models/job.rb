class Job < ApplicationRecord
  belongs_to :employer, touch: true
  has_many :applications, class_name: "JobApplication"
  has_many :job_candidates
  has_many :candidates, through: :job_candidates

  delegate :name, to: :employer, prefix: :employer, allow_nil: true

end
