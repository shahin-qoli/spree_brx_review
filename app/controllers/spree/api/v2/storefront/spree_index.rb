module Spree
    class SpreeIndex <::Spree::Api::V2::ResourceController
        before_action :require_spree_current_user
        def index # this function is for find all index of product and check is user is buyer or not and return to frontend
            product_id = params[:product_id]
            user = spree_current_user
            is_buyer = user.is_buyer(product_id)
            query = Spree::Index.where("product_id = '#{product_id}'")
            render json: { :query => "#{query}", :is_buyer => "#{is_buyer}"}, status: 200
        end
    end
end