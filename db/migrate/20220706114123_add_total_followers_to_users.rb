class AddTotalFollowersToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :total_followers, :integer, default: 0
  end
end
