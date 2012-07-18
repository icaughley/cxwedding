
class DropboxImagesController < ApplicationController
  # GET /dropbox_images
  def index
    @dropbox_images = DropboxImage.all
  end

  # GET /dropbox_images/1
  def show
    @dropbox_image = DropboxImage.find(params[:id])
  end

  # GET /dropbox_images/thumbnail/1
  def thumbnail
    dropbox_image = DropboxImage.find(params[:id])
    render text: dropbox_image.thumbnail, content_type: 'image/jpeg'
  end

  # GET /dropbox_images/thumbnails
  def thumbnails
    @image_ids = DropboxImage.all.map { |i| i.id }
  end

  # DELETE /gifts/1
  def destroy
    @dropbox_image = DropboxImage.find(params[:id])
    @dropbox_image.destroy
    flash[:notice] = 'Image has been deleted.'
    redirect_to dropbox_images_path
  end
end
