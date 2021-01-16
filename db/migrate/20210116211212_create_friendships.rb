class CreateFriendships < ActiveRecord::Migration[6.1]
  def change
    create_table :friendships do |t|
      t.references :user
      t.references :friend
      t.string :status

      t.timestamps
    end
  end
end
