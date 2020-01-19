class ChangeColumnName < ActiveRecord::Migration
  def change
  	rename_column :checklists, :date_id, :day_id
  end
end
