class UserSessionsController < ApplicationController
  skip_before_action :require_login, except: [:destroy]
  
  def index
    @user = User.new
  end
  
  def new
    @user = User.new
  end

  def create
    user = User.find_by(email: params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      log_in user
      redirect_to root_path, success: 'ログインに成功しました'
    else
      flash.now[:danger] = 'ログインに失敗しました'
      render action: 'new'
    end
  end

  def destroy
    logout
    redirect_to(:users, notice: 'ログアウトしました')
  end
  
  private
  def log_in(user)
    session[:user_id] = user.id
  end
end
