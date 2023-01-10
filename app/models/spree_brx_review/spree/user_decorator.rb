module Spree
    module UserDecorator
        def check_is_buyer(product_id)
            flag = false
            orders = self.orders
            if orders.blank?
                flag = false
            else
                orders.each do |order|
                    line = order.line_items
                    line.each do |items|
                        variant = items.variant
                        if variant.product_id == product_id
                            flag = true
                        else
                            flag = false
                        end
                    end
                end
            end
            flag
        end
    end
end