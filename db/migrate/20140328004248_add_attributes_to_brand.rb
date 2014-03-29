class AddAttributesToBrand < ActiveRecord::Migration
  def change
  	add_column :brands, :name, :string
  	add_column :brands, :website, :string
  	add_column :brands, :description, :string
  	add_column :brands, :hometown, :string
  	add_column :brands, :homestate, :string
  end
end
