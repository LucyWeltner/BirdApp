class RenameDates < ActiveRecord::Migration
  def change
  	rename_table :dates, :days
  end
end
