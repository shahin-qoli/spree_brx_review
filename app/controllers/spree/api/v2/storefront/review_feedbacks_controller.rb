module Spree::Api::V2::Storefront
    class ReviewFeedbacksController < ::Spree::Api::V2::ResourceController
        before_action :require_spree_current_user
        def create
            obj = Spree::ReviewFeedback.new
            obj.state = params[:state]
            obj.review_id = params[:review_id]
            obj.user_id = params[:user_id]
            if obj.save!
                render json: { message: "feedback saved successfully" }, status: 201
            else 
                render json: { message: "feedback not saved successfully" }, status: 404
            end
        end

        private

        def permitted_review_attributes
            [:review_id, :state]
        end
    end
end