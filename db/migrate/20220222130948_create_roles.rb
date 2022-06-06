class CreateRoles < ActiveRecord::Migration[6.1]
  def change
    create_table :roles do |t|
      t.string :name
      t.string :slug,  null: false
      t.timestamps
    end
    add_index :roles, :slug, unique: true
  end
end
