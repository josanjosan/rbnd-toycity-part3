class Product
	attr_reader :title, :price
	attr_accessor :stock

	@@products = []

	def initialize(options={})
		
		@title = options[	:title]
		@price = options[:price]
		@stock = options[:stock]
		
		add_product(self)
	end

	def self.all
		@@products
	end

	def self.find_by_title(some_title)
		product_found = @@products.select { |product| product.title == some_title }
		return product_found[0]
	end

	def in_stock?
		self.stock > 0
	end

	def self.in_stock
		@@products.select { |product| product.in_stock? }
	end

	private

	def add_product(new_product)
		name_taken = false
		
		@@products.each do |product|
			if product.title == new_product.title
				name_taken = true
			end
		end
		
		if name_taken == false
			@@products << new_product
		else
			puts "DuplicateProductError: product \"#{new_product.title}\" already exists." #WORKS
			#raise DuplicateProductError, "product \"#{new_product.title}\" already exists." #DOESN'T WORK
		end

	end

end