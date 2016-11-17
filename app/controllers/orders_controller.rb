class OrdersController < ApplicationController
	def update
		@order = current_order
		@order.update_attributes(order_params)
		
		@order_items = @order.order_items
		@current_order = @order
	end
	
	def destroy
		@order = current_order
		@order.update_attribute(:promotion_code, "")
		
		@order_items = @order.order_items
		@current_order = @order
	end
	
private
  def order_params
    params.require(:order).permit(:promotion_code)
  end
  
end
