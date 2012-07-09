class CreateDropboxImages < ActiveRecord::Migration
  def change
    create_table :dropbox_images do |t|
      t.string :filename
      t.binary :thumbnail
      t.string :url
      t.datetime :expires

      t.timestamps
    end
  end
end
