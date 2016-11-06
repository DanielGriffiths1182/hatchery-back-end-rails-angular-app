class UsersController < ApplicationController
  def show
  end

  def new
    @user = User.new
  end

  def create
    if User.all.empty?
      generate_user(true)
    else
      generate_user(false)
    end
    if @user.save
      render :json => @user
    else
      render_error @user.errors.full_message
    end
  end

  def edit
    @user = User.find(params[:id])
    @user.username = params[:username]
    @user.password = params[:password]
    @user.save
  end

  def login
    @user = User.find_by(username: params[:username])
    if !@user.nil?
      render :json => @user
    end
  end

  private
  def user_params
    params.require("users").permit(:username, :email, :password)
  end

  def generate_user(admin_status)
    @user = User.new(
      username: params[:username],
      email: params[:email],
      password: params[:password],
      admin: admin_status
    )
  end
end
