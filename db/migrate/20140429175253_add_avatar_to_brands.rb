class AddAvatarToBrands < ActiveRecord::Migration
  def change
    add_column :brands, :avatar, :string
  end
end
