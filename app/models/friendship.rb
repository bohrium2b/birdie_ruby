class Friendship < ApplicationRecord
  belongs_to :profile
  belongs_to :friend, class_name: 'Profile'
end