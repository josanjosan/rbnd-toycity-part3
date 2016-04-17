class Transaction
	attr_reader :id, :customer, :product

	@@transactions = []
	@@ids = 0

	def initialize(customer, product) 
		@id = @@ids + 1
		@customer = customer
		@product = product
		#require "date"
		#@date = Date.today
		
		make_transaction(customer, product)
	end

	def self.find(index)
		transaction_found = @@transactions.select { |transaction| transaction.id == index}
		return transaction_found[0]
	end

	def self.all
		@@transactions
	end

	private

	def make_transaction(customer, product)

		if product.in_stock?
			@@ids += 1
			@@transactions << self
			product.stock -= 1
		else
			puts "OutOfStockError: product \"#{product.title}\" is out of stock." #WORKS
			#raise OutOfStockError, "product \"#{product.title}\" is out of stock." #DOESN'T WORK
		end
	end

end