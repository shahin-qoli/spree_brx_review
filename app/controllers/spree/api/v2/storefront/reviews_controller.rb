module Spree::Api::V2::Storefront
      class ReviewsController < ApplicationController
        before_action :authenticate_user!
        #before_action :require_spree_current_user
        #before_action :init_pagination, only: [:index]

        def index # change params to sort_by=new 
          product_id = params[:product_id]
          @query = Spree::Review.all #where("product_id = '#{product_id}'").where("is_approved = '#{true}'").page(@pagination_page).per(@pagination_per_page)
          #summary = Spree::Review.summary(product_id)
          if params[:sort_by]
            sort_by = params[:sort_by]
            if sort_by == "new"
              @query = @query.order(created_at: :desc)
              render json: @query
            elsif sort_by == "rating"
              @query = @query.order(rating: :desc)
              render json: @query
            elsif sort_by == "old"
              @query = @query.order(created_at: :asc)
              render json: query
            elsif sort_by == "vote"
              @query = @query.order(up_vote: :desc)
              render json: @query
            end
          else
              render json: Spree::V2::Storefront::ReviewSerializer.new(@query) #@query, serializer: Spree::V2::Storefront::ReviewSerializer 
              #render json: {summary: "#{summary}"}
          end

        end
        def save_image
          #obj = Spree::ReviewImage.new
          review = Spree::Review.find(params[:review_id])
          images = params[:images]
          images.each do |image|
            review.create_image(attachment: image)
          end  
          #obj.review_id = params[:review_id]
          #obj.build_image(params[:images])
          #obj.images.attach([params[:image]])
          return render json: { message: "review saved" }, status: 201
        end
        protected

        def collection
          @collection ||= collection_finder.new(scope: scope, params: finder_params).execute
        end        
        
        def sorted_collection
          collection_sorter.new(collection, params, allowed_sort_attributes).call
        end        
        def collection_sorter
          Spree::Reviews::Sort #.constantize
        end
        def resource
            @resource ||= scope.find_by(scope.find(params[:id]))
        end
        def collection_serializer
          Spree::V2::Storefront::ReviewSerializer #.constantize
        end                

        def create
          obj = Spree::Review.new
          obj.variant_id = params[:variant_id].to_i
          obj.product_id = params[:product_id].to_i
          obj.user = spree_current_user
          obj.rating = params[:rating].to_i
          obj.suggest = params[:suggest]
          obj.review = params[:review]
          obj.up_vote = 0
          obj.down_vote = 0


          if params[:product_authenticity]
            obj.product_authenticity = params[:product_authenticity]
          end
          if params[:affordable]
            obj.affordable = params[:affordable]
          end
          if params[:quality]
            obj.quality = params[:quality]
          end
          if params[:packaging]
            obj.packaging = params[:packaging]
          end          

          if obj.save!
            render json: { message: "review saved" , review_id: obj.id }, status: 201
          else
            render json: { message: "vote can not save succesfully "  }, status: 404
          end

          if params[:pros]
            pros = params[:pros]
            pros.each do |pro|  
              obj_pros = Spree::ReviewConpron.new
              obj_pros.review_id = obj.id
              obj_pros.text = pro
              obj_pros.state = 1
              obj_pros.save!
            end
          end
          if params[:cons]
            cons = params[:cons]
            cons.each do |con|
              obj_cons = Spree::ReviewConpron.new
              obj_cons.review_id = obj.id
              obj_cons.text = con
              obj_cons.state = -1
              obj_cons.save!
            end
          end


        end


      


      
        def check_is_buyer
          product_id = params[:product_id]
          user_id = params[:user_id]
          user = Spree::User.find(user_id)
          flag = false
          orders = user.orders
          if orders.blank?
            flag = false
            render json: { is_buyer: "False"  }, status: 200
          else
              orders.each do |order|
                line = order.line_items
                line.each do |items|
                  variant = items.variant
                  if variant.product_id == product_id
                      flag = true
                      render json: { is_buyer: "True"  }, status: 200
                  else
                      flag = false
                      render json: { is_buyer: "False"  }, status: 200
                  end
                end
              end
          end
        end


        private
    
        def permitted_review_attributes
            [:rating,:review, :product_id, :variant_id]
        end
    
        def review_params
          params.require(:review).permit(permitted_review_attributes)
        end
        def init_pagination
          @pagination_page = params[:page].present? ? params[:page].to_i : 1
          @pagination_per_page = params[:per_page].present? ? params[:per_page].to_i : 5 # todo: add config in setting like Spree::Reviews::Config[:paginate_size]
        end
  end
end