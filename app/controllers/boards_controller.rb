class BoardsController < ApplicationController
	before_filter :signed_in_user, only: [:new, :create]

	def show
		@board = Board.find(params[:id])
	end
	
	def new
		@board = Board.new
	end
	
	def create
		@board = current_user.boards.create(params[:board])
		if @board.save
			flash[:success] = "Bulletin Board created successfully!"
			redirect_to @board
		else
			render 'new'
		end
	end
	
	def index
		@boards = Board.all
	end
	
	private
	def signed_in_user
		unless signed_in?
			store_location
			redirect_to(root_path, flash: { error: "Not signed in" })
		end
	end
end
