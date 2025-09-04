class Movie < ApplicationRecord
  has_many :reviews, dependent: :destroy
  has_many :movie_genres, dependent: :destroy
  has_many :genres, through: :movie_genres
  has_one_attached :poster

  validates :title, presence: true, uniqueness: true

  paginates_per 10

  scope :title_like, ->(q) {
    where("title LIKE ?", "%#{q}%") if q.present?
  }
  scope :by_genre, ->(gid) { joins(:movie_genres).where(movie_genres: { genre_id: gid }) if gid.present? }

  def update_avg_rating!
    update!(avg_rating: reviews.average(:rating).to_f.round(2))
  end
end