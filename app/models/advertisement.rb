class Advertisement < ActiveRecord::Base
	attr_accessible :width, :height, :image, :x_location, :y_location, :image_contents
	
	after_create :update_tiles
	
	has_many :tiles
	belongs_to :user
	belongs_to :board
	has_many :payment_details, as: :payable
	
	validates :x_location, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
	validates :y_location, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
	validates :width, presence: true, numericality: { only_integer: true, greater_than: 0}
	validates :height, presence: true, numericality: { only_integer: true, greater_than: 0}
	validates :image, presence: true
	
	validates :board, presence: true
	
	validate :size_constraints
	
	def update_tiles
		for y in (y_location)..(height - 1 + y_location)
			for x in (x_location)..(width - 1 + x_location)
				@tile = Tile.find(:first, joins: {advertisement: :board}, conditions: "tiles.x_location = #{x} AND tiles.y_location = #{y} AND boards.id = #{board.id}", readonly: false)
				#@tile = Tile.joins(advertisement: :board, readonly: false).where("tiles.x_location = #{x} AND tiles.y_location = #{y} AND boards.id = #{board.id}").first
				if @tile.nil?
					@tile = self.tiles.build(x_location: x, y_location: y)
					@tile.save()
				else
					@tile.advertisement_id = self.id
					@tile.save()
				end
			end
		end
	end
	
	def image_contents=(object)
		if !object.nil?
			self.image = object.read()
		end
	end
	
	def charge
		cost = -Tile.sum(:cost, conditions: ['advertisement_id = ?', self.id])
	
		if !cost.nil? && cost < 0.0
			payment_detail = self.user.payment_details.build(amount: cost)
			payment_detail.payable = self
			payment_detail.save()
		end
	end
	
	def size_constraints
		if x_location.is_a?(Integer) && y_location.is_a?(Integer) && width.is_a?(Integer) && height.is_a?(Integer)
			if x_location >= board.width
				errors.add(:x_location, "can't be larger than board width")
			end
			
			if y_location >= board.height
				errors.add(:y_location, "can't be larger than board height")
			end
			
			if width > board.width
				errors.add(:width, "can't be larger than board width")
			end
			
			if height > board.height
				errors.add(:height, "can't be larger than board height")
			end
			
			if x_location + width > board.width
				errors.add(:x_location, "combined can't be larger than the board width")
			end
			
			if y_location + height > board.height
				errors.add(:y_location, "combined can't be larger than the board height")
			end
		end
	end
 end
