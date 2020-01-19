class CreateLocations < ActiveRecord::Migration
  def change
  	create_table :locations do |table|
  		table.string :name 
  		table.string :state
  		table.string :country
  		table.integer :region_id
  	end
  end
end
