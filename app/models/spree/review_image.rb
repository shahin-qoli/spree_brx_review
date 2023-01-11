class Spree::ReviewImage < Spree::Asset
  include Spree::Configuration::ActiveStorage
  include Rails.application.routes.url_helpers
  include ::Spree::ImageMethods
  #has_many_attached :images
  #belongs_to :review

end
