class MoviesController < ApplicationController
  before_action :set_movie,     only: [:show, :edit, :update, :destroy]
  before_action :require_admin, only: [:new, :create, :edit, :update, :destroy]

  def index
    @genres = Genre.order(:name)
    @movies = Movie.with_attached_poster
                 .includes(:genres)
                 .page(params[:page])

    case params[:sort]
    when "rating"
      @movies = @movies.order(avg_rating: :desc)        # 評価順（高い順）
    when "title"
      @movies = @movies.order(:title)                   # 名前順（タイトル昇順）
    else
      @movies = @movies.order(release_year: :desc)      # デフォルト: 公開年新しい順
    end
  

  @movies = @movies.page(params[:page])
end

  def show
    @review = Review.new
  end

  def new
    @movie = Movie.new
  end

  def create
    @movie = Movie.new(movie_params)
    if @movie.save
      redirect_to @movie, notice: "映画を登録しました。"
    else
      flash.now[:alert] = @movie.errors.full_messages.join("、")
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @movie.update(movie_params)
      redirect_to @movie, notice: "映画情報を更新しました。"
    else
      flash.now[:alert] = @movie.errors.full_messages.join("、")
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @movie.destroy
    redirect_to movies_path, notice: "映画を削除しました。"
  end

  def search
    @genres = Genre.order(:name)
    @movies = Movie.with_attached_poster
                   .includes(:genres)
                   .title_like(params[:title])
                   .by_genre(params[:genre_id])
                   .order(avg_rating: :desc)
                   .page(params[:page])
    render :index
  end

  private

  def set_movie
    @movie = Movie.find(params[:id])
  end

  def movie_params
    params.require(:movie).permit(:title, :description, :release_year, :poster, genre_ids: [])
  end
end