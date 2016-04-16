class Transaction
	attr_reader :id, :customer, :product

	@@transactions = []
	@@ids = 0

	def initialize(customer, product) 
		@id = @@ids + 1
		@customer = customer
		@product = product
		@@ids += 1
		@@transactions << self
		product.stock -= 1
	end

	def self.all
		@@transactions
	end

end