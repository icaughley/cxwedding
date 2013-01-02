class GiftsController < ApplicationController

  before_filter :authenticate_user!

  # GET /gifts
  def index
    @gifts = Gift.all
  end

  # GET /gifts/1
  def show
    @gift = Gift.find(params[:id])
  end

  # GET /gifts/new
  def new
    @gift = Gift.new
  end

  # GET /gifts/1/edit
  def edit
    @gift = Gift.find(params[:id])
  end

  # POST /gifts
  def create
    @gift = Gift.new(params[:gift])
    @saved = @gift.save
    if @saved
      flash[:notice] = 'Gift was successfully created.'
    end
  end

  # PUT /gifts/1
  def update
    @gift = Gift.find(params[:id])

    @saved = @gift.update_attributes(params[:gift])
    if @saved
      flash[:notice] = 'Gift was successfully updated.'
    end
  end

  # DELETE /gifts/1
  def destroy
    @gift = Gift.find(params[:id])
    @gift.destroy
    flash[:notice] = 'Gift has been deleted.'
  end
end
