class RemoveLocationFromGiftsAndAlterValueToString < ActiveRecord::Migration
  def up
    remove_column :gifts, :location
    remove_column :gifts, :value
    add_column :gifts, :value, :string
  end

  def down
    add_column :gifts, :location, :string
    remove_column :gifts, :value
    add_column :gifts, :value, :decimal, precision: 8, scale: 2
  end
end
