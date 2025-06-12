class Cv < ApplicationRecord
  has_many :job_applications, dependent: :destroy
  has_many :jobs, through: :job_applications

  belongs_to :applicant

  validates :email, :status, presence: true

  enum :status, {
    pending: 0,
    approved: 1,
    rejected_120: 2,
    rejected_360: 3,
    spam_rejected: 4
  }

  enum :state, { scanned: 0, reviewed: 1 }

  attribute :status, :string, default: :pending
end
