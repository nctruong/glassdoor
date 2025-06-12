class Cv < ApplicationRecord
  has_many :job_applications, dependent: :destroy
  has_many :jobs, through: :job_applications

  belongs_to :applicant

  validates :email, :status, presence: true

  enum :status, {
    pending:       'Pending Review',
    approved:      'Approved',
    rejected_120:  '120 Rejected',
    rejected_360:  '360 Rejected',
    spam_rejected: 'Spam Rejected'
  }

  enum :state, { scanned: 'scanned', reviewed: 'reviewed' }

  attribute :status, :string, default: 'pending'
end
