class UsersController < ApplicationController
    def new
        @user = User.new
    end

	def create
	
		@order = current_order
		@user = User.new(user_params)
		@user.order_id = @order.id
	
		if @user.save
			@order.order_status_id = 2
			@order.save
			
			session.delete(:order_id)
			redirect_to users_thanks_path
		else
		  render 'new'
		end
	end
	
	def thanks
		
	end

private
    def user_params
      params.require(:user).permit(:name, :email, :cc_number, :address1)
    end
end
