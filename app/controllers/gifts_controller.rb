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

    if @gift.save
      redirect_to @gift, notice: 'Gift was successfully created.'
    else
      render action: :new
    end
  end

  # PUT /gifts/1
  def update
    @gift = Gift.find(params[:id])

    if @gift.update_attributes(params[:gift])
      redirect_to @gift, notice: 'Gift was successfully updated.'
    else
      render action: :edit
    end
  end

  # DELETE /gifts/1
  def destroy
    @gift = Gift.find(params[:id])
    @gift.destroy

    redirect_to gifts_url
  end
end
