class AddColumnGrouping < ActiveRecord::Migration
  def change
  	add_column :birds, :grouping, :string
  end
end
