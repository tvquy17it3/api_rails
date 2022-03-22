class AddDeletedAtToTimesheetDetails < ActiveRecord::Migration[6.1]
  def change
    add_column :timesheet_details, :deleted_at, :datetime
    add_index :timesheet_details, :deleted_at
  end
end
