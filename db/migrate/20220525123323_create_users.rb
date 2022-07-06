class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users  do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :password_digest

      t.string   :confirmation_token
      t.datetime :confirmed_at

      t.timestamps
    end
  end
end
