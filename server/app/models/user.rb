class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :applicant
  has_many :job_applications, through: :applicant
  has_many :cvs, through: :applicant

  belongs_to :employer, optional: true

  validates :name, length: {within: 0..50, too_long: 'Too many characters'}
  validates :email, presence: true, uniqueness: true
end
