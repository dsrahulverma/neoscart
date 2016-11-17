class CartsController < ApplicationController
  def show
    @order_items = current_order.order_items
	@current_order = current_order
	#@promotions = OrderPromotion.find(:all, :conditions => ["order_id = ?", current_order.id])
	@promotions = OrderPromotion.where(order_id: current_order.id).to_a
  end
end
