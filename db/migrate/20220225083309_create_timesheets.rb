class CreateTimesheets < ActiveRecord::Migration[6.1]
  def change
    create_table :timesheets do |t|
      t.datetime :check_in, index: true
      t.datetime :check_out, index: true
      t.string :location
      t.integer :hours
      t.integer :late
      t.integer :status
      t.text :note
      t.references :user, null: false, foreign_key: true, index: true
      t.references :shift, null: false, foreign_key: true, index: true

      t.timestamps
    end
  end
end
