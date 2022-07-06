class Comment < ApplicationRecord
  has_many :user_comments

  def self.get_user(comments)
    comments.map{ |c| [User.find(c.user_comments.pluck(:user_id)).pluck(:first_name, :last_name).join(' '), c.comment]}
  end
end
