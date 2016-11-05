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
      render_user
    else
      render_error @user.errors.full_message
    end
  end

  def edit
    @user = User.find(session[:user_id])
    @user.username = params[:user][:username]
    @user.password = params[:user][:password]
    @user.save
  end

  def login
    @user = User.find_by(username: params[:username])
    if !@user.nil?
      render_user
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

  def render_user
    render json: {
      id: @user.id,
      username: @user.username,
      email: @user.email,
      admin: @user.admin
    }
  end
end
