class Spree::ReviewImage < ActiveRecord::Base
  has_many_attached :images
  belongs_to :review

end
