class CreateSpreeReviewFeedbacks < ActiveRecord::Migration[6.1]
  def change
    create_table :spree_review_feedbacks do |t|
      t.integer :review_id,null:false
      t.integer :state #it can be 1 or -1
      t.integer :user_id,null:false
      t.timestamps 
    end
  end
end
