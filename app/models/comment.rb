class Comment < ActiveRecord::Base
  has_many :votes, as: :voteable
  belongs_to :post
  belongs_to :creator, foreign_key: 'user_id', class_name: 'User'

  validates :body, presence: true
end
