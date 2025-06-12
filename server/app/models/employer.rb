class Employer < ApplicationRecord
  has_many :jobs
  has_many :employees

  validates :name, uniqueness: { case_sensitive: false }
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP, message: "is invalid" }

  validates :short_description, length: {maximum: 100, too_long: 'Limit 100 characters'}
  validates :long_description, length: {maximum: 1000, too_long: 'Limit 1000 characters'}
end
