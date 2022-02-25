class User < ApplicationRecord
  has_secure_password
  has_one_attached :avatar

  has_many :term_comments
  has_many :courses
  has_many :members

  validates :username, uniqueness: true
  validates :email, uniqueness: true
end
