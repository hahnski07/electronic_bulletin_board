class StaticPagesController < ApplicationController
	def home
	end
	
	def cost_estimate
		board = Board.find(params[:board])
		x_location = Integer(params[:x_location])
		y_location = Integer(params[:y_location])
		width = Integer(params[:width])
		height = Integer(params[:height])
		
		cost = 0.0
		
		for y in (y_location)..(height - 1 + y_location)
			for x in (x_location)..(width - 1 + x_location)
				tile = Tile.find(:first, joins: {advertisement: :board}, conditions: "tiles.x_location = #{x} AND tiles.y_location = #{y} AND boards.id = #{board.id}")
				cost = cost + [tile.cost * 2.0, 1.0].max * 2.0
			end
		end
		
		render(text: "{\"estimatedCost\": #{cost}}", content_type: "application/json")
	end
	
	def charge_advertisements
		advertisements = Advertisement.all
		advertisements.each do |advertisement|
			advertisement.charge()
		end
		
		boards = Board.all
		boards.each do |board|
			board.age()
		end
		
		render(text: "Advertisements charged successfully!", content_type: "text/plain")
	end
end
