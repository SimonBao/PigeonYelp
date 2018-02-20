class CreateReviews < ActiveRecord::Migration[5.1]
  def change
    create_table :reviews do |t|
      t.integer :rating, limit: 5
      t.text :body
      t.references :restaurant, foreign_key: true

      t.timestamps
    end
  end
end
