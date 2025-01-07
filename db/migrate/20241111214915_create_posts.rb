class CreatePosts < ActiveRecord::Migration[7.1]
  def change
    create_table :posts do |t|
      t.string :title
      t.references :profile, null: false, foreign_key: true
      t.text :body
      t.text :stats

      t.timestamps
    end
  end
end
