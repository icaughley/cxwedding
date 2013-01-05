require 'open-uri'

class DropboxController < ApplicationController

  before_filter :authenticate_user!
  before_filter :must_be_admin!, except: [:refresh]
  before_filter :must_have_dropbox_authority, except: [:authorize]

  def authorize
    if params[:oauth_token]
      DropboxHelper.store_dropbox_session( session )
      redirect_to action: :index
    else
      dbsession = DropboxHelper.new_session
      session[:dropbox_session] = dbsession.serialize
      redirect_to dbsession.get_authorize_url url_for(action: 'authorize')
    end
  end

  def index
    return redirect_to(action: :authorize) unless @client

    @images = DropboxImage.all
  end

  # Refreshes an image that has expired
  def refresh
    @dropbox_image = DropboxImage.find(params[:id])

    media = @client.media(@dropbox_image.filename)
    @dropbox_image.url = media["url"]
    @dropbox_image.expires = media["expires"]
    @dropbox_image.save!

    redirect_to @dropbox_image
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
    # Remove leading / if one exists
    image_path = image_path[1..-1] if image_path[0] == '/'

    return if DropboxImage.exists?(filename: image_path)

    dropbox_image = DropboxImage.new
    dropbox_image.filename = image_path
    dropbox_image.thumbnail = @client.thumbnail(ERB::Util.url_encode(image_path), 'm')
    dropbox_image.save!

    DropboxHelper.shrink_image( @client, dropbox_image )

    @image = dropbox_image
  end


  private

  # Called by the before_filter
  def must_have_dropbox_authority
    @client = DropboxHelper.create_client( session )
  end
end
