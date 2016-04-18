require_relative "lib/errors"
require_relative "lib/customer"
require_relative "lib/product"
require_relative "lib/transaction"
# PRODUCTS

Product.new(title: "LEGO Iron Man vs. Ultron", price: 22.99, stock: 55)
Product.new(title: "Nano Block Empire State Building", price: 49.99, stock: 12)
Product.new(title: "LEGO Firehouse Headquarter", price: 199.99, stock: 0)

puts Product.all.count # Should return 3

Product.new(title: "LEGO Iron Man vs. Ultron", price: 22.99, stock: 55)
puts Product.all.count# Should return DuplicateProductError: 'LEGO Iron Man vs. Ultron' already exists.

nanoblock = Product.find_by_title("Nano Block Empire State Building")
firehouse = Product.find_by_title("LEGO Firehouse Headquarter")

puts nanoblock.title # Should return 'Nano Block Empire State Building'
puts nanoblock.price # Should return 49.99
puts nanoblock.stock # Should return 12
puts nanoblock.in_stock? # Should return true
puts firehouse.in_stock? # Should return false

products_in_stock = Product.in_stock
# Should return an array of all products with a stock greater than zero
puts products_in_stock.include?(nanoblock) # Should return true
puts products_in_stock.include?(firehouse) # Should return false

# CUSTOMERS

Customer.new(name: "Walter Latimer")
Customer.new(name: "Julia Van Cleve")

puts Customer.all.count # Should return 2

Customer.new(name: "Walter Latimer")
# Should return DuplicateCustomerError: 'Walter Latimer' already exists.

walter = Customer.find_by_name("Walter Latimer")

puts walter.name # Should return "Walter Latimer"

# TRANSACTIONS

transaction = Transaction.new(walter, nanoblock)

puts transaction.id # Should return 1
puts transaction.product == nanoblock # Should return true
puts transaction.product == firehouse # Should return false
puts transaction.customer == walter # Should return true

puts nanoblock.stock # Should return 11

# PURCHASES

puts walter.purchase(nanoblock)

puts Transaction.all.count # Should return 2

transaction2 = Transaction.find(2)
puts transaction2.product == nanoblock # Should return true

walter.purchase(firehouse)
#Should return OutOfStockError: 'LEGO Firehouse Headquarter' is out of stock.

### NEW FEATURES ###

# ITEM RETURN
walter.return_item(nanoblock, 5) #Should return TransactionNotFoundError: the transaction id provided cannot be found in the transactions record. 
puts nanoblock.stock #Should still return 10

julia = Customer.find_by_name("Julia Van Cleve")
julia.return_item(nanoblock, 1)
puts nanoblock.stock #Should still return 10

walter.return_item(firehouse, 1) #Should return InvalidTransactionIdError: the product "LEGO Firehouse Headquarter" does not correspond to a purchase made in transaction 1.
puts nanoblock.stock #Should still return 10

walter.return_item(nanoblock, 2) 
puts nanoblock.stock #All return checks are met so this time nanoblock stock should have had to go up by one and this line should return 11

# ADVANCED TRANSACTION FINDER

ironman = Product.find_by_title("LEGO Iron Man vs. Ultron")
julia.purchase(ironman)
julia.purchase(nanoblock)
puts Transaction.advanced_find("Julia Van Cleve") # When only customer name is given, should return array with 2 transactions made by this customer
puts Transaction.advanced_find("Julia Van Cleve", "LEGO Iron Man vs. Ultron") # Now that