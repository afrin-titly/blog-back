class Post < ApplicationRecord
  belongs_to :user
  has_many :user_comments
  has_many :comments, through: :user_comments

  def self.followers_post(followers)
    posts = []
    followers.map{ |f| posts.push(User.find(f.follow).posts.order(created_at: :desc))}
    return posts.flatten
  end

end
