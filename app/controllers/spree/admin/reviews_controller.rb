module Spree::Admin::Reviews
    class Spree::Admin::ReviewsController <::Spree::Api::V2::ResourceController
        #before_action :require_spree_current_user
        def index
            @reviews = Spree::Review.where(is_approved: false)
            #render json: query, include: ['user','variant','review_conpron','review_image'], status: 200
            #render "spree/admin/reviews/reviews"
        end

        def approve
            review = Spree::Review.find(params[:id])
            user = spree_current_user
            review.approver_id = user
            review.is_approved = true
            if review.save!
                render json: { message: "review saved successfully"}, status: 200
            else
                render json: { message: "review not saved successfully"}, status: 404
            end
        end
        def not_approve
            review = Spree::Review.find(params[:id])
            user = spree_current_user
            review.approver_id = user
            if review.destroy!
                render json: { message: "review deleted from admin panel successfully"}, status: 200
            else
                render json: { message: "review not deleted from admin panel successfully"}, status: 400
            end
        end
    end
end
