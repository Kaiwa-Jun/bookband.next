class ApplicationController < ActionController::Base
  before_action :require_login #sorceryが作成するメソッド。ログインしてない時not_authenticatedメソッドを発火する
  protect_from_forgery with: :exception

  add_flash_types :success, :info, :warning, :danger
  
  def not_authenticated
    redirect_to login_url
  end
end
