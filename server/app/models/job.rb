class Job < ApplicationRecord
  belongs_to :employer, touch: true

  has_many :job_applications

  # for matching function
  has_many :job_candidates
  has_many :candidates, through: :job_candidates

  delegate :name, to: :employer, prefix: :employer, allow_nil: true

  def self.sort_with(field: 'published_at', direction: 'asc')
    order(field => direction)
  end
end
