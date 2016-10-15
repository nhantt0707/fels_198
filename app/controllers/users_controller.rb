class UsersController < ApplicationController
  before_action :logged_in_user, except: [:create, :new]
  before_action :find_user, only: :show

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      log_in @user
      flash[:success] = t "flash.login_success"
      redirect_back_or user
    else
      render :new
    end
  end

  def show
  end

  private
  def find_user
    @user= User.find_by_id params[:id]
    unless @user
      flash[:danger] = t "flash.find_user_fail"
      redirect_to root_path
    end
  end

  def user_params
    params.require(:user).permit :name, :email, :password, 
      :password_confirmation 
  end

  def valid_user
    redirect_to root_url unless @user == current_user
  end
end
