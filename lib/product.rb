class Product
	attr_reader :title, :price, :stock

	@@products = []

	def initialize(options={})
		
		@title = options[:title]
		@price = options[:price]
		@stock = options[:stock]
		name_taken = false

		@@products.each do |product|
			if product.title == options[:title]
				name_taken = true
			end
		end
		
		if name_taken == false
			@@products << self
		else
			puts "DuplicateProductError: the product \"#{options[:title]}\" already exists." #WORKS
			#raise DuplicateProductError, "the product \"#{options[:title]}\" already exists." #DOESN'T WORK
		end

	end

	def self.all
		@@products
	end

	private
end