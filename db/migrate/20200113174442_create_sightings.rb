class CreateSightings < ActiveRecord::Migration
  def change
  	create_table :sightings do |table|
  		table.integer :checklist_id
  		table.integer :bird_id
  	end
  end
end
