class AddBookingToReviews < ActiveRecord::Migration[5.2]
  def change
    remove_column :reviews, :post_id
    add_reference :reviews, :booking, foreign_key: true
  end
end
