class Review < ApplicationRecord
  belongs_to :user
  belongs_to :movie

    # 1作品に1レビュー
  validates :user_id, uniqueness: { scope: :movie_id, message: "は同じ作品に複数レビューできません" }

  validates :rating,
            presence: { message: "点数を付けていないため投稿できません。" },
            numericality: {
              greater_than_or_equal_to: 1.0,
              less_than_or_equal_to: 5.0,
              allow_nil: true
            }


  after_commit :recalc_movie_avg

  private

  def recalc_movie_avg
    avg = movie.reviews.average(:rating)&.round(1) || 0.0
    movie.update!(avg_rating: avg)
  end
end