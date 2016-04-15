class Product
	attr_reader :title, :price, :stock

	@@products = []

	def initialize(options={})
		
		@title = options[:title]
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

	def self.include?(some_product)
		self.find_by_title(some_product.title).count > 0
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
			puts "DuplicateProductError: the product \"#{self.title}\" already exists." #WORKS
			#raise DuplicateProductError, "the product \"#{options[:title]}\" already exists." #DOESN'T WORK
		end

	end

end