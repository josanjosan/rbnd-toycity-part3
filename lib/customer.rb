class Customer
	attr_reader :name, :id

	@@customers = []
	@@customer_counter = 0

	def initialize(options = {})
		@name = options[:name]
		add_customer(self)
	end

	def self.all
		@@customers
	end

	def self.find_by_name(some_name)
		customer_found = @@customers.select { |customer| customer.name == some_name }
		return customer_found[0]
	end

	def purchase(product)
		Transaction.new(self, product)
	end

	def return_item(product, transaction_id)
		transaction_found = Transaction.find(transaction_id)
		transaction_check = transaction_found.nil?
		customer_check = false
		product_check = false
		
		unless transaction_check
			customer_check = (transaction_found.customer.name == self.name)
			product_check = (transaction_found.product.title == product.title)
		end
		
		if transaction_check == true
			puts "TransactionNotFoundError: the transaction id provided cannot be found in the transactions record."
			#raise TransactionNotFoundError, "the transaction id provided cannot be found in the transactions record."
		elsif customer_check == false
			puts "InvalidTransactionIdError: the transaction id provided does not correspond to a transaction made by #{self.name}."
			#raise InvalidTransactionIdError, "the transaction id provided does not correspond to a transaction made by #{self.name}."
		elsif product_check == false
			puts "InvalidTransactionIdError: the product \"#{product.title}\" does not correspond to a purchase made in transaction #{transaction_id}."
			#InvalidTransactionIdError, "the product \"#{product.title}\" does not correspond to a purchase made in transaction #{transaction_id}."
		else
			product.stock += 1
		end

	end

	private

	def add_customer(new_customer)
		names = @@customers.map { |customer| customer.name }
		name_taken = names.include?(new_customer.name)

		if name_taken == false
			@@customer_counter += 1
			@@customers << new_customer
		else
			puts "DuplicateCustomerError: customer \"#{new_customer.name}\" already exists." #WORKS
			#raise DuplicateCustomerError, "customer \"#{new_customer.name}\" already exists." #DOESN'T WORK
		end
	
	end

end