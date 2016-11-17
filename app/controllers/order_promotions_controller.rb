class OrderPromotionsController < ApplicationController
  def create
	@promotion = OrderPromotion.new(promotion_params)
	@promotion.order_id = current_order.id
	
	@order = current_order
	if @promotion.save
	
		@expromo = OrderPromotion.where(:order_id=>current_order.id, :value=>@promotion.value).first
		
		if @expromo.blank?
			flash[:notice] = 'Not a valid promo code.'
			redirect_to cart_path
		else
		
			#@promotions = OrderPromotion.where(order_id: current_order.id).to_a
			
			@promo = Promotion.where(:name => @promotion.value).first
			if @promo.promo_type == 'percent'
				@discount  = (@order.subtotal.to_s.to_d * @promo.value.to_s.to_d)/100
			else
				@discount  = @promo.value
			end

			@order.total_discount = (@order.total_discount+@discount).to_d
			@order.total  = @order.total - @discount
			@order.save
		
			redirect_to cart_path
		end
	end
	
  end

  def destroy
	@promotion = OrderPromotion.find(params[:id])
	
	@order = current_order
	if @promotion.destroy
	
		@promo = Promotion.where(:name => @promotion.value).first
		if @promo.promo_type == 'percent'
			@discount  = (@order.subtotal.to_s.to_d * @promo.value.to_s.to_d)/100
		else
			@discount  = @promo.value
		end

		@order.total_discount = (@order.total_discount-@discount).to_d
		@order.total  = @order.total + @discount
		@order.save
		
		redirect_to cart_path
	end

  end
  
private
  def promotion_params
	params.require(:order_promotion).permit(:value)
  end
end
