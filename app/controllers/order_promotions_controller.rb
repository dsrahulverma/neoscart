class OrderPromotionsController < ApplicationController
	
	def create
		@promotion = OrderPromotion.new(promotion_params)
		
		# check if promotion code is valid
		@promo = Promotion.where(:name => @promotion.value).first
		if @promo.blank?
			flash[:notice] = 'Not a valid promo code.'
			redirect_to cart_path
		else
			# check if promotion code is already applied
			@expromo = OrderPromotion.where(:order_id=>current_order.id, :promo_id=>@promo.id).first
			if !@expromo.blank?
				flash[:notice] = 'Promo code already applied.'
				redirect_to cart_path
			else
				# get applied promotion code
				@appliedpromotion = OrderPromotion.where(order_id: current_order.id).first
				
				# check if promocode can be used with other promo codes
				if !@appliedpromotion.blank? and @promo.conjunction == false
					flash[:notice] = 'Promo code can not be used with other promo code.'
					redirect_to cart_path
				else
					
					if !@appliedpromotion.blank?
						@appliedpromotiondetail = Promotion.where(:id => @appliedpromotion.promo_id).first
						
						# to check applied promo code allow other code
						if @appliedpromotiondetail.conjunction == false
							flash[:notice] = 'Please delete applied promo code and try again.'
							redirect_to cart_path
						else
							
							@promotion.order_id = current_order.id
							@promotion.promo_id = @promo.id
							
							if @promotion.save
								@order = current_order
								
								# check promo code type and calculate the discount and update
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
					else
				
						@promotion.order_id = current_order.id
						@promotion.promo_id = @promo.id
						
						if @promotion.save
							@order = current_order
							
							# check promo code type and calculate the discount and update
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
