class AddUserIdAndImageIdToGift < ActiveRecord::Migration
  def change
    add_column :gifts, :user_id, :integer
    add_column :gifts, :image_id, :integer
  end
end
