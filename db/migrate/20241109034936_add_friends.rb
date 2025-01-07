class AddFriends < ActiveRecord::Migration[7.1]
  def change
    create_table :friendships do |t|
      t.references :profile, null: false, foreign_key: true
      t.references :friend, null: false, foreign_key: { to_table: :profiles }
      t.timestamps
    end

    add_index :friendships, [:profile_id, :friend_id], unique: true
  end
end
