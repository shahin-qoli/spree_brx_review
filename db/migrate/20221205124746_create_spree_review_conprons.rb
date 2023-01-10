class CreateSpreeReviewConprons < ActiveRecord::Migration[6.1]
  def change
    create_table :spree_review_conprons do |t|
      t.integer :review_id,null:false
      t.text    :text ,null:true
      t.string :state ,null:false # TODO: define validation to ensure that state is in ( CON, PRON)
      t.timestamps 
    end
  end
end