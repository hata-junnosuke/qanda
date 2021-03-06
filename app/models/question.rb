class Question < ApplicationRecord
  belongs_to :user

  validates :title, presence: true, length: { maximum: 30 }
  validates :body, presence: true, length: { maximum: 1000 }
  has_many :answers, dependent: :destroy

  # 以下検索条件を絞るための実装。これでtitle,body以外を検索できないようになる。
  def self.ransackable_attributes(auth_object = nil)
    %w[title body]
  end

  def self.ransackable_associations(auth_object = nil)
    []
  end
end
