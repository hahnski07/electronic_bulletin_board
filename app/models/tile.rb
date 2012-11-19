class Tile < ActiveRecord::Base
	attr_accessible :x_location, :y_location

	belongs_to :advertisement
	has_one :board, through: :advertisement
	
	validates :x_location, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
	validates :y_location, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
	validates :cost, presence: true, numericality: {greater_than_or_equal_to: 0 }
	
	validate :size_constraints
	
	def size_constraints
		if self.x_location >= self.board.width
			errors.add(:x_location, "can't be larger than board width")
		end

		if self.x_location < self.advertisement.x_location
			errors.add(:x_location, "can't be smaller than advertisement x_location")
		end

		if self.x_location > (self.advertisement.x_location + self.advertisement.width - 1)
			errors.add(:x_location, "can't be larger than the advertisement")
		end

		if self.y_location >= self.board.height
			errors.add(:y_location, "can't be larger than board height")
		end

		if self.y_location < self.advertisement.y_location
			errors.add(:y_location, "can't be smaller than advertisement y_location")
		end

		if self.y_location > (self.advertisement.y_location + self.advertisement.height - 1)
			errors.add(:y_location, "can't be larger than the advertisement")
		end
	end
end