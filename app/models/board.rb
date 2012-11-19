class Board < ActiveRecord::Base
	attr_accessible :height, :name, :timezone, :width
  
	has_many :tiles, through: :advertisements
	has_many :advertisements
	belongs_to :user
	has_one :payment_detail, as: :payable
	
	validates :name, presence: true
	validates :height, presence: true, numericality: { only_integer: true, greater_than: 0 }
	validates :width, presence: true, numericality: { only_integer: true, greater_than: 0 }
	validates_inclusion_of :timezone, in: ActiveSupport::TimeZone.zones_map { |m| m.name }, message: "is not a valid Timezone"
end
