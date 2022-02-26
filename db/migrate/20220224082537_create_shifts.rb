class CreateShifts < ActiveRecord::Migration[6.1]
  def change
    create_table :shifts do |t|
      t.string :name
      t.time :check_in, null: false, index: true
      t.time :check_out, null: false, index: true

      t.timestamps
    end
  end
end
