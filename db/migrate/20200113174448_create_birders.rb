class CreateBirders < ActiveRecord::Migration
  def change
  	create_table :birders do |table|
  		table.string :name
  		table.string :email
  		table.string :password_digest
  	end
  end
end
