class CreateChecklists < ActiveRecord::Migration
  def change
  	create_table :checklists do |table|
  		table.integer :birder_id
  		table.integer :location_id
  		table.integer :date_id
  		table.time :start_time 
  		table.time :end_time
  		table.integer :temperature
  		table.string :weather
  		table.string :distance_travelled
  	end
  end
end
