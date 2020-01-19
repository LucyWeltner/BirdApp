class CreateDates < ActiveRecord::Migration
  def change
  	create_table :dates do |table|
  		table.date :name 
  	end
  end
end
