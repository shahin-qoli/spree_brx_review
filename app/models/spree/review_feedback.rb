class Spree::ReviewFeedback < ActiveRecord::Base
    belongs_to :user, class_name: Spree.user_class.to_s
    belongs_to :review, dependent: :destroy
    validates :review, presence: true
    before_save :check_user
    after_save  :update_review
    #before_action :require_spree_current_user

    OPTIONS = [1,-1]
    validates_inclusion_of :state, :in => OPTIONS

    def check_user 
      user = self.user_id
      review_id = self.review_id
      query = Spree::ReviewFeedback.where("review_id = '#{review_id}'").where("user_id = '#{user}'")
      return if query.present?
      errors[:base] << "You voted to this review later" if query.present?
    end
  def update_review
      review = Spree::Review.find(self.review_id)
      state = self.state
      if state == 1
          review.up_vote +=1
          review.save!
      end
      if state == -1
          review.down_vote += 1 
          review.save!
      end
  end
  end
  
