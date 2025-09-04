class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in?
  before_action :set_genres  

  private

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def logged_in?
    current_user.present?
  end

  def require_login
    return if logged_in?
    redirect_to login_path, alert: "ログインしてください。"
  end

  def set_genres
    @genres = Genre.order(:name)
  rescue ActiveRecord::StatementInvalid
    @genres = Genre.none
  end

  def require_admin
    unless logged_in? && current_user.admin?
      redirect_to root_path, alert: "管理者のみアクセスできます"
    end
  end
end