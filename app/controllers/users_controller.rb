class UsersController < ApplicationController

  before_filter :authenticate_user!
  before_filter :must_be_admin!

  # GET /users
  def index
    @users = User.all
  end

  # GET /users/1
  def show
    @user = User.find(params[:id])
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # PUT /users/1
  def update
    @user = Gift.find(params[:id])

    if @user.update_attributes(params[:gift])
      redirect_to @user, notice: 'Gift was successfully updated.'
    else
      render action: :edit
    end
  end

  # DELETE /users/1
  def destroy
    @user = User.find(params[:id])
    @user.destroy
  end

  # PUT /users/:user_id/make_admin
  def toggle_admin
    @user = User.find(params[:user_id])

    # Can't change the admin state of user 1
    unless @user.id == 1
      @user.admin = !@user.admin?
      @user.save!
    end

    render :replace_user
  end
end
