class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :user_job_applications, dependent: :destroy
  has_many :job_applications, through: :user_job_applications

  # has_secure_password\
  has_one :applicant

  validates :name, presence: true
  validates :name, length: {within: 0..50, too_long: 'Too many characters'}
  validates :email, presence: true, email: true, uniqueness: true
end
