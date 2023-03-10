class Spree::Review < ActiveRecord::Base
    belongs_to :product, touch: true
    belongs_to :user, class_name: Spree.user_class.to_s
    belongs_to :variant
    has_many   :review_feedback
    has_many   :review_conpron
    #has_many_attached :images 
    #before_save :images_limit_min 
    after_save :recalculate_product_rating, if: :approved
    after_destroy :recalculate_product_rating
    has_many :images, as: :viewable, dependent: :destroy, class_name: 'Spree::ReviewImage'
  
    validates :rating, numericality: {
      only_integer: true,
      greater_than_or_equal_to: 1,
      less_than_or_equal_to: 5,
      message: :you_must_enter_value_for_rating
    }
    OPTIONS = ['sug','not_sug','not_sure',nil]
    validates_inclusion_of :suggest, :in => OPTIONS
  
    #default_scope { order('spree_reviews.created_at DESC') }
  
    scope :most_recent_first, -> { order('spree_reviews.created_at DESC') }
    scope :oldest_first, -> { reorder('spree_reviews.created_at ASC') }
    scope :preview, -> { limit(Spree::Reviews::Config[:preview_size]).oldest_first }
    scope :approved, -> { where(is_approved: true) }
    scope :not_approved, -> { where(is_approved: false) }
    scope :default_approval_filter, -> { Spree::Reviews::Config[:include_unapproved_reviews] ? all : approved }

    acts_as_paranoid
    #def images_limit_min
      #return if self.images.length>5
     # errors[:base] << "You can upload only 5 photos" if self.photos.length > 5
  #  end
  def approved # this logic return true or false based on approved 
    self.is_approved?
  end


  def summary(product_id)
    product = Spree::Product.find(product_id)
    all_reviews = product.reviews_count
    avg_rating = product.avg_rating.to_i
    query_review = Spree::Review.where("is_approved = '#{true}'").where("product_id = '#{product.id}'")
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


    def feedback_stars
      return 0 if feedback_reviews.size <= 0
  
      ((feedback_reviews.sum(:rating) / feedback_reviews.size) + 0.5).floor
    end
  
    def recalculate_product_rating
      self.product.recalculate_rating if product.present?
    end
  end
