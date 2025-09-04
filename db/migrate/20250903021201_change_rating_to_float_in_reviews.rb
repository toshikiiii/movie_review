class ChangeRatingToFloatInReviews < ActiveRecord::Migration[7.1]
  def change
    change_column :reviews, :rating, :float, null: false, default: 0.0
  end
end