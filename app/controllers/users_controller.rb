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
      render json: {
        id: @user.id,
        username: @user.username,
        email: @user.email,
        admin: @user.admin
      }
    else
      render_error @user.errors.full_message
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
