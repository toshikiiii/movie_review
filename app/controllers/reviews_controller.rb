class ReviewsController < ApplicationController
  before_action :require_login
  before_action :set_movie
  before_action :set_review, only: [:edit, :update, :destroy]
  before_action :require_author_or_admin, only: [:edit, :update, :destroy]

  def create
    @review = @movie.reviews.build(review_params.merge(user: current_user))
    if @review.save
      redirect_to @movie, notice: "レビューを投稿しました。"
    else
      flash.now[:alert] = @review.errors.full_messages.join("、")
      render "movies/show", status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @review.update(review_params)
      redirect_to @movie, notice: "レビューを更新しました。"
    else
      flash.now[:alert] = @review.errors.full_messages.join("、")
      render :edit, status: :unprocessable_entity
    end
  end


  def destroy
    @review.destroy!
    redirect_to @movie, notice: "レビューを削除しました。"
  end

  private

  def set_movie
    @movie = Movie.find(params[:movie_id])
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path, alert: "映画が見つかりません" and return
  end

  def set_review
    @review = @movie.reviews.find_by(id: params[:id])
    redirect_to @movie, alert: "レビューが見つかりません" and return unless @review
  end

  def require_author_or_admin
    unless current_user&.admin? || @review.user_id == current_user&.id
      redirect_to @movie, alert: "この操作は許可されていません" and return
    end
  end

  def review_params
    params.require(:review).permit(:rating, :comment)
  end
end