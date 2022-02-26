class CreateTimesheetDetails < ActiveRecord::Migration[6.1]
  def change
    create_table :timesheet_details do |t|
      t.string :latitude
      t.string :longitude
      t.integer :distance
      t.decimal :accuracy
      t.string :ip_address
      t.text :img
      t.decimal :confidence
      t.text :note
      t.integer :starus
      t.references :timesheet, null: false, foreign_key: true, index: true

      t.timestamps
    end
  end
end
