class GenresController < ApplicationController
  before_action :require_admin
  before_action :set_genre, only: [:edit, :update, :destroy]  

  def index
    @genres = Genre.order(:name)
  end

  def new
    @genre = Genre.new
  end

  def create
    @genre = Genre.new(genre_params)
    if @genre.save
      redirect_to genres_path, notice: "ジャンルを追加しました。"
    else
      flash.now[:alert] = @genre.errors.full_messages.join("、")
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @genre.update(genre_params)
      redirect_to genres_path, notice: "ジャンルを更新しました。"
    else
      flash.now[:alert] = @genre.errors.full_messages.join("、")
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @genre.destroy
    redirect_to genres_path, notice: "ジャンルを削除しました。"
  end

  private

  def set_genre
    @genre = Genre.find(params[:id]) 
  end

  def genre_params
    params.require(:genre).permit(:name)
  end
end