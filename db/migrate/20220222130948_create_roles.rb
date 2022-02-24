class CreateRoles < ActiveRecord::Migration[6.1]
  def change
    create_table :roles do |t|
      t.string :name
      t.string :slug, index: { unique: true }
      t.timestamps
    end
  end
end
