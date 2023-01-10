class CreateSpreeIndex < ActiveRecord::Migration[6.1]
  def change
    create_table :spree_indexes do |t|
      t.integer :product_id,null: true
      t.string :name ,null: true
      t.boolean :is_default, null: true
      t.timestamps 
    end
  end
end
