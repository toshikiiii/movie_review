class AlterReviewsRatingDefaultAndNull < ActiveRecord::Migration[7.1]
  def up
    change_column :reviews, :rating, :float

    execute "UPDATE reviews SET rating = 0.0 WHERE rating IS NULL"

    change_column_default :reviews, :rating, 0.0
    change_column_null    :reviews, :rating, false
  end

  def down
    change_column_null    :reviews, :rating, true
    change_column_default :reviews, :rating, nil
  end
end