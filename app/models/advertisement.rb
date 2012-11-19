class Advertisement < ActiveRecord::Base
	attr_accessible :width, :height, :image, :x_location, :y_location

	has_many :tiles
	belongs_to :user
	belongs_to :board
	has_many :payment_details, as: :payable
	
	validates :x_location, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
	validates :y_location, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
	validates :width, presence: true, numericality: { only_integer: true, greater_than: 0}
	validates :height, presence: true, numericality: { only_integer: true, greater_than: 0}
	validates :image, presence: true
	
	validate :size_constraints
	
	def size_constraints
		if self.x_location >= self.board.width
			errors.add(:x_location, "can't be larger than board width")
		end
		
		if self.y_location >= self.board.height
			errors.add(:y_location, "can't be larger than board height")
		end
		
		if self.width > self.board.width
			errors.add(:width, "can't be larger than board width")
		end
		
		if self.height > self.board.height
			errors.add(:height, "can't be larger than board height")
		end
		
		if self.x_location + self.width > self.board.width
			errors.add(:x_location, "combined can't be larger than the board width")
		end
		
		if self.y_location + self.height > self.board.height
			errors.add(:y_location, "combined can't be larger than the board height")
		end
	end
 end
