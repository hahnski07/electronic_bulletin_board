class Tile < ActiveRecord::Base
	attr_accessible :x_location, :y_location

	belongs_to :advertisement
	has_one :board, through: :advertisement
	
	validates :x_location, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
	validates :y_location, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
	validates :cost, presence: true, numericality: {greater_than_or_equal_to: 0 }
	
	validate :size_constraints
	
	def age
	
	end
	
	private
	def size_constraints
		if x_location.is_a?(Integer) && y_location.is_a?(Integer)
			if x_location >= board.width
				errors.add(:x_location, "can't be larger than board width")
			end

			if x_location < advertisement.x_location
				errors.add(:x_location, "can't be smaller than advertisement x_location")
			end

			if x_location > (advertisement.x_location + advertisement.width - 1)
				errors.add(:x_location, "can't be larger than the advertisement")
			end

			if y_location >= board.height
				errors.add(:y_location, "can't be larger than board height")
			end

			if y_location < advertisement.y_location
				errors.add(:y_location, "can't be smaller than advertisement y_location")
			end

			if y_location > (advertisement.y_location + advertisement.height - 1)
				errors.add(:y_location, "can't be larger than the advertisement")
			end
		end
	end
end