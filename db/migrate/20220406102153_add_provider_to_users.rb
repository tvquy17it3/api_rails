class AddProviderToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :provider, :string
    add_column :users, :uid, :string
    add_column :users, :accesstoken, :string
    add_column :users, :refreshtoken, :string
    add_column :users, :image, :string
  end
end
