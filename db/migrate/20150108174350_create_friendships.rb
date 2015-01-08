class CreateFriendships < ActiveRecord::Migration
  def change
    create_table :friendships do |t|
    	t.string :user_id
			t.string :friend_id
			t.string :status

      t.timestamps
    end
    add_index :friendships, :user_id
  end
end
