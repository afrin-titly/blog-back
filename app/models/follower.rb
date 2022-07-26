class Follower < ApplicationRecord
  # has_many :users
  validates :user_id, uniqueness: { scope: :follow }
  validate :self_follower?
  validate :count_followers, on: :create

  def self_follower?
    if user_id == follow
      errors.add(:user_id, "Don't be so obsessed with yourself. You can't follow yourself.")
    end
  end

  def count_followers
    u = User.find(self.user_id)
    u.total_followers += 1
    u.save
  end

end
