class JobCandidate < ApplicationRecord
  belongs_to :job
  belongs_to :cv, class_name: 'CV'
  belongs_to :candidate

  enum status: {
    pending:   'Pending',
    previewed: 'Previewed',
    viewed:    'Viewed',
    invited:   'Invited',
    accepted:  'Accepted'
  }
end
