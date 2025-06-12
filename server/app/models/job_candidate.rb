# Detecting candidates for a job
class JobCandidate < ApplicationRecord
  belongs_to :job
  belongs_to :cv, class_name: 'Cv'
  belongs_to :candidate

  enum :status, {
    pending:   'Pending',
    previewed: 'Previewed',
    viewed:    'Viewed',
    invited:   'Invited',
    accepted:  'Accepted'
  }
end
