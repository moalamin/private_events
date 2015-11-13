class UsersController < ApplicationController
	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)

		if @user.save
			flash[:success] = "New user created"
			log_in(@user)
			redirect_to @user
		else
			render 'new'
		end
	end

	def show
		@user = User.find(params[:id])
		@events = @user.created_events.order(created_at: :desc)
	end

	private

	def user_params
		params.require(:user).permit(:name, :email)
	end
end
