require 'dropbox_sdk'
require 'RMagick'

include Magick

APP_KEY = "kzkmfhkkp2wlwi6"
APP_SECRET = "vebt1gaq7aa7yfb"
ACCESS_TYPE = :app_folder

class DropboxController < ApplicationController

  before_filter :authenticate_user!
  before_filter :must_be_admin!

  before_filter :must_have_dropbox_authority, only: [:index, :thumbnail, :show]

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

    @info = @client.metadata('/')

    @images = @client.metadata('/')["contents"].map { |c| c["path"] }


    #@folder_url = @client.media( '/IMAG0001.jpg' )[ "url" ]
    #@poik = $contents.map{ |c| @client.media( c[ "path" ] )[ "url" ]}
  end

  def thumbnail
    thumbnail_blob = @client.thumbnail(params[:img], 'medium')
    render text: thumbnail_blob, content_type: 'image/jpeg'
    #img = Magick::Image.from_blob( thumbnail_blob )
    #small_img = img.first.minify
    #render text: small_img.to_blob, content_type: 'image/jpeg'
  end

  def show
    @image_name = params[:img]
    @image_url = @client.media( @image_name )[ "url" ]
  end

  private

  def save_session(dbsession)
    session[:dropbox_session] = dbsession.serialize
    SystemProperty.set!( SystemProperty::DB_SESSION, session[:dropbox_session] )
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
