class ApplicationController < ActionController::Base
  before_action :require_login #ログインしてないとコンテンツが見れない
end
