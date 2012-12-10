class UsersController < ApplicationController
	before_filter :signed_in_user, only: [:index, :show]
	before_filter :admin_user, only: [:index]
	before_filter :correct_user, only: [:show]
	
	def show
		@user = User.find(params[:id])
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
				flash[:success] = "Welcome to the Electronic Bulletin Board!"
				redirect_to @user
			else
				render 'new'
			end
		end
	end
	
	def index
		@users = User.all
	end
	
	def edit
	end
	
	def update
		if @user.update_attributes(params[:user])
			flash[:success] = "Profile updated"
			sign_in @user
			redirect_to @user
		else
			render 'edit'
		end
	end
	
	def destroy
		if !User.find(params[:id]).admin? && User.find(params[:id]) != current_user
			User.find(params[:id]).destroy
			flash[:success] = "User destroyed."
			redirect_to users_url
		end
	end
	
	private
	def signed_in_user
		unless signed_in?
			store_location
			redirect_to(root_path, flash: { error: "Not signed in!" })
		end
	end
	
	def admin_user
		unless current_user.admin?
			redirect_to(root_path, flash: { error: "Not an administrator!" })
		end
	end
	
	def correct_user
		@user = User.find(params[:id])
		
		unless current_user?(@user)
			redirect_to(user_path(current_user), flash: { error: "Wrong user!" })
		end
	end
end
