class CreateRegions < ActiveRecord::Migration
  def change
  	create_table :regions do |table|
  		table.string :name
  	end
  end
end
