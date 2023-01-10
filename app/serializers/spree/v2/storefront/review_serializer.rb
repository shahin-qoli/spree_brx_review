module Spree
  module V2
    module Storefront
      class ReviewSerializer < BaseSerializer
        puts "FFFFFFFFFF************"
        set_type :review
        attributes :review, :rating, :up_vote,  :down_vote, :suggest, :summary

        belongs_to :user, serializer: :user, id_method_name: :user_id, object_method_name: :user_id, record_type: :user
        belongs_to :variant
        #belongs_to :review_image
        has_many   :review_conpron

        
      end
    end
  end
end
