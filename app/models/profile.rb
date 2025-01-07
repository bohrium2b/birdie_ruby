class Profile < ApplicationRecord
  belongs_to :user
  validates :handle, presence: true, uniqueness: true
  validates :user, presence: true
  validates :bio, length: { maximum: 160 }
  has_many :friendships
  has_many :friends, through: :friendships
  has_many :inverse_friendships, class_name: 'Friendship', foreign_key: 'friend_id'
  has_many :posts
end
