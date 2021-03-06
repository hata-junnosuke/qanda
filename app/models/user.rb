class User < ApplicationRecord
  has_secure_password
  has_one_attached :image

  validates :name, presence: true, length: { maximum: 15 }
  validates :email, presence: true, length: { maximum: 255 },
            format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
            uniqueness: { case_sensitive: false }

  has_many :questions, dependent: :destroy
  has_many :answers, dependent: :destroy

  scope :related_to_question, ->(question) { joins(:answers).where(answers: { question_id: question.id }) }

  def mine?(object)
    object.user_id == id
  end
end
