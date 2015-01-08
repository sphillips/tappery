class Friendship < ActiveRecord::Base
	# validates_uniqueness_of :friend_id, :scope => :user_id

	def update_both(status=nil)
		sister = Friendship.find(:first, :conditions => ["user_id = ? AND friend_id = ?", self.friend_id, self.user_id])
		self.update_attributes(:status => status) && sister.update_attributes(:status => status)
	end

	def delete_both
		sister = Friendship.find(:first, :conditions => ["user_id = ? AND friend_id = ?", self.friend_id, self.user_id])
		self.destroy && sister.destroy
	end
end
