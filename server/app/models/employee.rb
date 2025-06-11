class Employee < ApplicationRecord
  validates :name, :title, length: {within: 0..30, too_long: 'Limit 30 characters'}, allow_blank: true
end
