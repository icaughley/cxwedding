class CreateSystemProperties < ActiveRecord::Migration
  def change
    create_table :system_properties do |t|
      t.string :property_key
      t.string :property_value
      t.timestamps
    end
  end
end
