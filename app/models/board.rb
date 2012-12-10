class Board < ActiveRecord::Base
	include ActionView::Helpers
	
	attr_accessible :height, :name, :timezone, :width
  
	after_create :create_fake_advertisement, :charge_account
  
	has_many :tiles, through: :advertisements
	has_many :advertisements
	belongs_to :user
	has_one :payment_detail, as: :payable
	
	validates :name, presence: true
	validates :height, presence: true, numericality: { only_integer: true, greater_than: 0 }
	validates :width, presence: true, numericality: { only_integer: true, greater_than: 0 }
	validates_inclusion_of :timezone, in: ActiveSupport::TimeZone.zones_map { |m| m.name }, message: "is not a valid Timezone"
	
	def create_fake_advertisement
		advertisement = self.advertisements.build(x_location: 0, y_location: 0, width: self.width, height: self.height)
		advertisement.image = File.open(Rails.root.to_s + "/app/assets/images/background.jpg", "rb") { |io| io.read }
		advertisement.user = User.find_by_id(1)
		advertisement.save()
	end
	
	def charge_account
		payment_detail = self.user.payment_details.build(amount: 1.0 * width * height)
		payment_detail.payable = self
		payment_detail.save()
	end
	
	def age
		#cost = Tile.sum(:cost, joins: {advertisement: :board}, conditions: ['boards.id = ?', self.id])
		#if cost > 0.0
		#	payment_detail = self.user.payment_details.build(amount: cost)
		#	payment_detail.payable = self
		#	payment_detail.save()
		#end
		
		self.advertisements.each do |ad|
			ad.charge
			ActiveRecord::Base.connection.execute("Update tiles SET cost = CAST(cost / 2.0 * 100.0 AS int) / 100.0 WHERE advertisement_id = #{ad.id}")
			#ad.tiles.each do |tile|
			#	tile.age()
			#	tile.save()
			#end
		end
		
		
	end
end
