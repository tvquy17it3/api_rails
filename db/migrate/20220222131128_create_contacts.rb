class CreateContacts < ActiveRecord::Migration[6.1]
  def change
    create_table :contacts do |t|
      t.string :name, null: false
      t.string :phone
      t.string :address
      t.string :gender

      t.timestamps
    end

    add_reference :contacts, :user
  end
end
