class CreateSpreeReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :spree_reviews do |t|
      t.integer :variant_id,null:false
      t.integer :product_id,null:false
      t.integer :user_id ,null:false
      t.integer :rating ,null:false
      t.integer    :approver_id ,null:true
      t.text    :review ,null:false
      t.boolean :is_approved, default: false
      t.boolean :is_buyer, default: false
      t.timestamps
      t.integer :up_vote,defult:0 ##TODO: we have to update this field for every upvote and down vote # done
      t.integer :down_vote,defult:0 ##TODO: we have to update this field for every upvote and down vote # done
      t.string :suggest ,null:true  ##TODO: we need to validate the entry text in our model # done
      t.integer :product_authenticity ,null:true
      t.integer :packaging ,null:true
      t.integer :quality ,null:true
      t.integer :affordable ,null:true
      t.datetime :deleted_at
    end
  end
end

#finalized