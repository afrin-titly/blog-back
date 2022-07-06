class User < ApplicationRecord
  has_secure_password
  has_many :posts
  has_many :followers
  has_many :user_comments
  has_many :comments, through: :user_comments

  validates :email, uniqueness: true

  def admin?
    id == 1
  end

  def my_followers
    following_ids = self.followers_list.pluck(:follow)
    followers_name(following_ids)
  end

  def followers_name(ids)
    follows = User.find(ids)
    follows.map {|f| [f.id, (f.first_name + " " + f.last_name)]}
  end

  def followers_list
    self.followers
  end

  def who_follow_me
    followers = Follower.where(follow: self.id).pluck(:user_id)
    unless followers.nil?
      my_followers = User.find(followers).pluck(:id)
      followers_name(my_followers)
      # return my_followers.map {|f| [f[0], f[1] + " " + f[2]]}
    end
  end

  def not_following
    return User.all.pluck(:id) - self.followers_list.pluck(:follow) - [self.id]
  end

  def suggest_to_follow
    users = User.find(self.not_following).pluck(:id, :first_name, :last_name)
    list = []
    users.map{|u| list.push({id: u[0], name: u[1] + " " +u[2]})}
    return list
  end

end
