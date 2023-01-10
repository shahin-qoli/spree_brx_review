class AddRateColumnsToSpreeProducts < ActiveRecord::Migration[6.1]
  def change
    add_column :spree_products, :avg_rating, :decimal, default: 0.0, null: true, precision: 7, scale: 5
    add_column :spree_products, :reviews_count, :integer, default: 0, null: true
  end
end
