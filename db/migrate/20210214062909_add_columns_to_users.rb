class AddColumnsToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :bio, :text
    add_column :users, :city, :string
    add_column :users, :school, :string
    add_column :users, :workplace, :string
    add_column :users, :hometown, :string
    add_column :users, :rel_status, :string
  end
end
