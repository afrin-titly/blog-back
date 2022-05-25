class CreateFollowers < ActiveRecord::Migration[6.1]
  def change
    create_table :followers do |t|
      t.integer :follower
      t.integer :follow

      t.timestamps
    end
  end
end
