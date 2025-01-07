class CreateProfiles < ActiveRecord::Migration[7.1]
  def change
    create_table :profiles do |t|
      t.references :user, null: false, foreign_key: true
      t.text :handle
      t.boolean :ispublic
      t.text :bio
      t.text :gender
      

      t.timestamps
    end
  end
end
