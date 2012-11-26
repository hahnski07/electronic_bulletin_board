class PaymentDetail < ActiveRecord::Base
	attr_accessible :amount
  
	belongs_to :payable, polymorphic: true
	belongs_to :user
	
	validates :amount, presence: true, numericality: { only_integer: false }
end
