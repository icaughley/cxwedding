class CreateGifts < ActiveRecord::Migration
  def change
    create_table :gifts do |t|
      t.string :title
      t.string :description
      t.string :location
      t.decimal :value, precision: 8, scale: 2

      t.timestamps
    end
  end
end
