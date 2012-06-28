class AddAdminAndNameToUsers < ActiveRecord::Migration
  def change
    add_column :users, :admin, :boolean, default: false, nullable: false
    add_column :users, :name, :string
  end
end
