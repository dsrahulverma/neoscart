class OrderPromotion < ActiveRecord::Base
	belongs_to :order

	#before_save :check_for_duplicates

	def check_for_duplicates
	  #if OrderPromotion.find(:all, :conditions => ["order_id = ? and value = ?", self.order_id, self.value])
		
		if OrderPromotion.where(order_id: self.order_id, value:self.value)
			#OrderPromotion.error.add("some error")
		end
	end

end
