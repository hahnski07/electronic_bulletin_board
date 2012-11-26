class UsersController < ApplicationController
	def show
	end
	
	def new
		if signed_in?
			redirect_to root_path
		else
			@user = User.new
		end
	end
	
	def create
		if signed_in?
			redirect_to root_path
		else
			@user = User.new(params[:user])
			if @user.save
				sign_in @user
				flash[:success] = "Welcome to the Electronic Bulliten Board!"
				redirect_to @user
			else
				render 'new'
			end
		end
	end
end
