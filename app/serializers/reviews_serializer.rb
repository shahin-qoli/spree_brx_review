class ReviewsSerializer < ActiveModel::Serializer
  include JSONAPI::Serializer
  attributes :review, :rating, :up_vote,  :down_vote, :suggest, :summary

  belongs_to :user, serializer: :user, id_method_name: :user_id, object_method_name: :user_id, record_type: :user
  belongs_to :variant
  #belongs_to :review_image
  has_many   :review_conpron as: :viewable
  def summary
    product_id = object.product_id
    all_reviews = product.reviews_count
    avg_rating = product.avg_rating.to_i
    query_review = Spree::Review.where("is_approved = '#{true}'").where("product_id = '#{product_id}'")
    all_sug = 0
    all_not_sug = 0
    all_not_sure = 0
    all_buyer = 0
    for i in query_review
      if i.suggest == "sug"
        all_sug+=1
        all_buyer +=1
      elsif i.suggest == "not_sug"
        all_not_sug += 1
        all_buyer +=1
      elsif i.suggest == "not_sure"
        all_not_sure +=1 
        all_buyer +=1
        end
      end
      summary = [avg_rating,all_reviews,all_sug,all_not_sug,all_not_sure,all_buyer]  
      summary
  end

end
