class CreateSpreeReviewIndex < ActiveRecord::Migration[6.1]
  def change
    create_table :spree_review_indexes do |t|
      t.integer :review_id,null:false
      t.integer :index_id,null:false      
      t.float :rating ,null:true
      t.timestamps 
    end
  end
end