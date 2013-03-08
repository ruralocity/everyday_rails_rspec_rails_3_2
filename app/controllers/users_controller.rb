class UsersController < ApplicationController
  before_filter :authenticate
  load_and_authorize_resource

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      redirect_to users_url, notice: 'New user created.'
    else
      render :new
    end
  end
end
