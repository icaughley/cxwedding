require 'dropbox_sdk'
require 'RMagick'

module DropboxHelper
  include Magick

  ACCESS_TYPE = :app_folder

  MAX_WIDTH = 480
  MAX_HEIGHT = 480

  APP_KEY = "kzkmfhkkp2wlwi6"
  APP_SECRET = "vebt1gaq7aa7yfb"

  def self.create_client(session)
    if session[:dropbox_session]
      dbsession = DropboxSession.deserialize(session[:dropbox_session])
    else
      database_session = SystemProperty.get(SystemProperty::DB_SESSION)
      if database_session
        dbsession = DropboxSession.deserialize(database_session)
      else
        return
      end
    end

    begin
      return DropboxClient.new(dbsession, ACCESS_TYPE)
    rescue
      return nil
    end
  end

  def self.store_dropbox_session(session)
    # the user has returned from Dropbox
    dbsession = DropboxSession.deserialize(session[:dropbox_session])
    dbsession.get_access_token

    # Save dbsession to DB and session
    session[:dropbox_session] = dbsession.serialize
    SystemProperty.set!(SystemProperty::DB_SESSION, session[:dropbox_session])
  end

  # Shrink the image and then put it back in the drop box.
  def self.shrink_image(client, dropbox_image)
    magick_image = Magick::Image.from_blob(client.get_file dropbox_image.filename).first
    if magick_image.columns > MAX_WIDTH or magick_image.rows > MAX_HEIGHT
      magick_image = magick_image.resize_to_fit(MAX_WIDTH, MAX_HEIGHT)
      client.put_file(dropbox_image.filename, magick_image.to_blob, true)
    end
  end

  def self.new_session
    DropboxSession.new(APP_KEY, APP_SECRET)
  end
end