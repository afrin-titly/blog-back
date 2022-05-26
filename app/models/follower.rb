class Follower < ApplicationRecord
  # has_many :users
  validates :user_id, uniqueness: { scope: :follow }
  validate :self_follower?

  def self_follower?
    if user_id == follow
      errors.add(:user_id, "Don't be so obsessed with yourself. You can't follow yourself.")
    end
  end

end
