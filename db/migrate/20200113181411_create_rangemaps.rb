class CreateRangemaps < ActiveRecord::Migration
  def change
  	create_table :rangemaps do |table|
  		table.integer :bird_id 
  		table.integer :region_id 
  	end
  end
end
