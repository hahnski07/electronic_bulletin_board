class ImagesController < ApplicationController
	
	def show
		@advertisement = Advertisement.find(params[:id])
		render(text: @advertisement.image, content_type: "image/jpeg")
	end
	
end
