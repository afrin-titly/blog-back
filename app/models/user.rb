class User < ApplicationRecord
  has_many :posts
  has_many :followers
  has_many :comments
end
