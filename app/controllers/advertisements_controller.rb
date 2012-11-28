class AdvertisementsController < ApplicationController
	def new
		@board = Board.find(params[:board_id])
		@advertisement = Advertisement.new()
	end
	
	def create
		@board = Board.find(params[:board_id])
		@advertisement = @board.advertisements.build(params[:advertisement])
		@advertisement.image = @advertisement.image.read()
		@advertisement.user = current_user
		if @advertisement.save
			flash[:success] = "Advertisement created successfully!"
			redirect_to @board
		else
			render 'new'
		end
	end
	
	def image_contents=(image)
		image.read()
	end
end
