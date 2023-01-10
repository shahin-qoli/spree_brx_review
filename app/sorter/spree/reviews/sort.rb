module Spree
  module Products
    class Sort < ::Spree::BaseSorter


        def call
          reviews = by_param_attributes(scope)
          reviews = by_new(reviews)
          reviews = by_old(reviews)
          reviews = by_rating(reviews)
          reviews = by_vote(reviews)

        end

        private
        attr_reader :sort, :scope, :allowed_sort_attributes

        def by_new(scope)
          return scope unless (value = sort_by?('new'))
          scope.order(created_at: :desc)
        end
        
        def by_old(scope)
          return scope unless (value = sort_by?('old'))
          scope.order(created_at: :asc)          
        end
        def by_rating(scope)
          return scope unless (value = sort_by?('rating'))
          scope.order(rating: :desc)           
        end
        def by_vote(scope)
          return scope unless (value = sort_by?('vote'))
          scope.order(up_vote: :desc)           
        end                        

        def sort_by?(field)
          sort.detect { |s| s[0] == field }
        end
    end
  end
end      