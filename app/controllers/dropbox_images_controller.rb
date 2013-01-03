
#This controller is only kept around for debugging and admin.
class DropboxImagesController < ApplicationController

  before_filter :authenticate_user!

  # GET /dropbox_images
  def index
    @dropbox_images = DropboxImage.all
  end

  # GET /dropbox_images/thumbnail/1
  def thumbnail
    thumbnail_blob = DropboxImage.find(params[:id]).thumbnail
    render text: thumbnail_blob, content_type: 'image/jpeg'
  end

  # GET /dropbox_images/thumbnails
  def thumbnails
    @image_ids = DropboxImage.all.map { |i| i.id }
  end

  # DELETE /dropbox_images/1
  def destroy
    @dropbox_image = DropboxImage.find(params[:id])
    @dropbox_image.destroy
    flash[:notice] = 'Image has been deleted.'
    redirect_to dropbox_images_path
  end
end
