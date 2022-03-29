class AddDeletedAtToContacts < ActiveRecord::Migration[6.1]
  def change
    add_column :contacts, :deleted_at, :datetime
    add_index :contacts, :deleted_at
  end
end
