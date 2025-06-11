class Employer < ApplicationRecord
  has_many :jobs
  has_many :employees

  validates :name, uniqueness: { case_sensitive: false }
  validates :email, email: true
  validates :short_description, length: {maximum: 100, too_long: 'Limit 100 characters'}
  validates :long_description, visible_text_length: {maximum: 1200}
end
