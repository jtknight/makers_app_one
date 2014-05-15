class AddBrandIdToVideos < ActiveRecord::Migration
  def change
  	remove_column :videos, :user_id, :integer
  	add_column :videos, :brand_id, :integer
  end
end
