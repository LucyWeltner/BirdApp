class CreateBirds < ActiveRecord::Migration
  def change
  	create_table :birds do |table|
  		table.string :common_name
  		table.string :latin_name
  		table.text :description
  		table.string :image_url
  	end
  end
end
