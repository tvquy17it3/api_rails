class AddDeletedAtToTimesheets < ActiveRecord::Migration[6.1]
  def change
    add_column :timesheets, :deleted_at, :datetime
    add_index :timesheets, :deleted_at
  end
end
