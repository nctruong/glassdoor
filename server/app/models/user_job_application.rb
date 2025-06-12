
class UserJobApplication < ApplicationRecord
  belongs_to :user
  belongs_to :job_application
end
