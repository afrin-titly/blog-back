class User < ApplicationRecord
  has_secure_password
  has_many :posts
  has_many :followers
  has_many :comments

  def admin?
    id == 1
  end

end
