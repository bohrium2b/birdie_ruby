class AddName < ActiveRecord::Migration[7.1]
  def change
    add_column :profiles, :name, :text
  end
end
