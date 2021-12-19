class User < ApplicationRecord
  has_secure_password
  has_one_attached :image

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true

  has_many :questions
  has_many :answers, dependent: :destroy
end
