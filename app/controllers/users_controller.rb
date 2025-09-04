class UsersController < ApplicationController
  before_action :require_login, only: [:edit, :update]
  before_action :set_user,      only: [:edit, :update]
  before_action :authorize!,    only: [:edit, :update]

  def new
    @user = User.new
  end

def show
  @user = User.find(params[:id])
  @reviews = @user.reviews.includes(:movie).order(created_at: :desc)
end

  def create
    @user = User.new(user_params_create)
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path, notice: "アカウントを作成しました。"
    else
      flash.now[:alert] = @user.errors.full_messages.to_sentence
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

def update
  # 1) 画像削除チェック（"1" のときだけ削除）
  if params.dig(:user, :remove_avatar) == "1"
    @user.avatar.purge_later if @user.avatar.attached?
  end

  # 2) remove_avatar を除外して更新
  safe_params = user_params_update.except(:remove_avatar)

  if @user.update(safe_params)
    redirect_to edit_account_path, notice: "プロフィールを更新しました。"
  else
    flash.now[:alert] = @user.errors.full_messages.to_sentence
    render :edit, status: :unprocessable_entity
  end
end

  private

  def set_user
    # ログイン中の本人を編集対象にする
    @user = current_user
  end

  def authorize!
    redirect_to login_path, alert: "ログインしてください。" unless current_user
  end

  def require_login
    redirect_to login_path, alert: "ログインしてください。" unless current_user
  end

  # 新規作成時に許可する項目
  def user_params_create
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :avatar, :bio)
  end

  # 更新時に許可する項目
  def user_params_update
    permitted = [:name, :email, :avatar, :remove_avatar, :bio]
    # パスワード欄が空なら無視、入っていれば更新
    if params[:user][:password].present?
      permitted += [:password, :password_confirmation]
    end
    params.require(:user).permit(permitted)
  end
end