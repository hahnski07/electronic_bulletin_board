class AdvertisementsController < ApplicationController
	def new
		@board = Board.find(params[:board_id])
		@advertisement = Advertisement.new()
	end
	
	def create
		@board = Board.find(params[:board_id])
		@advertisement = @board.advertisements.build(params[:advertisement])
		@advertisement.user = current_user
		@advertisement.image_contents = params[:advertisement_image_contents]
		if @advertisement.save
			flash[:success] = "Advertisement created successfully! (#{@advertisement.x_location}, #{@advertisement.y_location})"
			redirect_to @board
		else
			render 'new'
		end
	end
end
