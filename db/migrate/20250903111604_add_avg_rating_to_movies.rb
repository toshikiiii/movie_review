class AddAvgRatingToMovies < ActiveRecord::Migration[7.1]
  def up
    unless column_exists?(:movies, :avg_rating)
      add_column :movies, :avg_rating, :float, null: false, default: 0.0
    else
      change_column_default :movies, :avg_rating, 0.0
      change_column_null    :movies, :avg_rating, false
    end
  end

  def down
    remove_column :movies, :avg_rating, if_exists: true
  end
end