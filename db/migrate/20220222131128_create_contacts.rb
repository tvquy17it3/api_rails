class CreateContacts < ActiveRecord::Migration[6.1]
  def change
    create_table :contacts do |t|
      t.string :name, null: false
      t.string :phone
      t.string :address
      t.string :gender
      t.references :user, null: false, foreign_key: true, index: true

      t.timestamps
    end
  end
end
