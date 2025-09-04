class CreateMovies < ActiveRecord::Migration[8.0]
  def change
    create_table :movies do |t|
      t.string :title
      t.text :description
      t.integer :release_year
      t.float :avg_rating

      t.timestamps
    end
    add_index :movies, :title, unique: true
  end
end
