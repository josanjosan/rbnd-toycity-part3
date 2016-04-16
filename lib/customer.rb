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