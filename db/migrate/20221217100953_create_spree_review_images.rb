class CreateSpreeReviewImages < ActiveRecord::Migration[6.1]
  def change
    create_table :spree_review_images do |t|
    t.integer :review_id, :null => false
    t.timestamps
    end
  end
end
