require 'dropbox_sdk'
require 'RMagick'
require 'open-uri'

include Magick

APP_KEY = "kzkmfhkkp2wlwi6"
APP_SECRET = "vebt1gaq7aa7yfb"
ACCESS_TYPE = :app_folder

MAX_WIDTH = 480
MAX_HEIGHT = 480

class DropboxController < ApplicationController

  before_filter :authenticate_user!
  before_filter :must_be_admin!, except: [:show]

  before_filter :must_have_dropbox_authority, except: [:authorize]

  def authorize
    if not params[:oauth_token] then
      dbsession = DropboxSession.new(APP_KEY, APP_SECRET)
      session[:dropbox_session] = dbsession.serialize
      redirect_to dbsession.get_authorize_url url_for(:action => 'authorize')
    else
      # the user has returned from Dropbox
      dbsession = DropboxSession.deserialize(session[:dropbox_session])
      dbsession.get_access_token

      # Save dbsession to DB and session
      save_session(dbsession)

      redirect_to :action => 'index'
    end
  end

  def index
    return redirect_to(:action => 'authorize') unless @client

    #@info = @client.metadata('/')["contents"]

    @images = DropboxImage.all

    #@folder_url = @client.media( '/IMAG0001.jpg' )[ "url" ]
    #@poik = $contents.map{ |c| @client.media( c[ "path" ] )[ "url" ]}
  end

  def thumbnail
    thumbnail_blob = DropboxImage.find(params[:id]).thumbnail
    render text: thumbnail_blob, content_type: 'image/jpeg'
  end

  def show
    @dropbox_image = DropboxImage.find(params[:id])

    if @dropbox_image.expired?
      media = @client.media(@dropbox_image.filename)
      @dropbox_image.url = media["url"]
      @dropbox_image.expires = media["expires"]
      @dropbox_image.save
    end
  end

  def import
    contents = @client.metadata('/')["contents"]

    index = params[:id].to_i
    @next_index = index + 1

    if @next_index == contents.length
      @progress = 100
      flash[:notice] = 'All images imported.'
    else
      @progress = (@next_index * 100.0 / contents.length).to_i
    end

    image_path = contents[index]["path"]

    return if DropboxImage.exists?(filename: image_path)

    dropbox_image = DropboxImage.new

    dropbox_image.filename = image_path
    dropbox_image.thumbnail = @client.thumbnail(ERB::Util.url_encode(image_path), 'large')

    dropbox_image.save!

    # Shrink the image and then put it back in the drop box.
    magick_image = Magick::Image.from_blob(@client.get_file @dropbox_image.filename).first
    if magick_image.columns > MAX_WIDTH or magick_image.rows > MAX_HEIGHT
      magick_image = magick_image.resize_to_fit(MAX_WIDTH, MAX_HEIGHT)
      @client.put_file(@dropbox_image.filename, magick_image.to_blob, true)
    end

    @image = dropbox_image
  end


  private

  def save_session(dbsession)
    session[:dropbox_session] = dbsession.serialize
    SystemProperty.set!(SystemProperty::DB_SESSION, session[:dropbox_session])
  end

  # Called by the before_filter
  def must_have_dropbox_authority
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
      @client = DropboxClient.new(dbsession, ACCESS_TYPE)
    rescue
      @client = nil
    end
  end
end
