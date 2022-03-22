class AddDeletedAtToShifts < ActiveRecord::Migration[6.1]
  def change
    add_column :shifts, :deleted_at, :datetime
    add_index :shifts, :deleted_at
  end
end
