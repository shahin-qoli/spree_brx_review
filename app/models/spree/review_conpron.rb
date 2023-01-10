class Spree::ReviewConpron < ActiveRecord::Base
  has_many :review, dependent: :destroy
  end
  