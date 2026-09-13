puts "🌱 Starting database seeding..."

def random_date(start_date, end_date)
  rand(start_date..end_date)
end

puts "Clearing existing data..."
Review.delete_all
Shipment.delete_all
Payment.delete_all
OrderItem.delete_all
Order.delete_all
Address.delete_all
Product.delete_all
Supplier.delete_all
Category.delete_all
User.delete_all
Department.delete_all

department_names = %w[Engineering Finance Sales Marketing Operations Human\ Resources]
departments = department_names.map { |name| Department.create!(name: name) }
category_names = %w[Electronics Laptops Mobiles Accessories Home\ Appliances Furniture Books Clothing Sports Beauty]
categories = category_names.map { |name| Category.create!(name: name) }
suppliers = 20.times.map { |i| Supplier.create!(name: "Supplier #{i + 1}") }

salary_pool = [30_000, 35_000, 40_000, 45_000, 50_000, 55_000, 60_000, 65_000, 70_000, 75_000, 80_000, 90_000, 100_000, 120_000, 150_000, 200_000]
statuses = %w[active active active inactive suspended]
users = 100.times.map do |i|
  User.create!(name: "User #{i + 1}", email: "user#{i + 1}@example.com", salary: salary_pool.sample,
               department: departments.sample, status: statuses.sample,
               created_at: random_date(Date.new(2023, 1, 1), Date.new(2026, 8, 31)))
end

cities = [["Indore", "Madhya Pradesh"], ["Pune", "Maharashtra"], ["Mumbai", "Maharashtra"], ["Bangalore", "Karnataka"], ["Ahmedabad", "Gujarat"], ["Delhi", "Delhi"], ["Hyderabad", "Telangana"], ["Chennai", "Tamil Nadu"]]
150.times do
  city, state = cities.sample
  Address.create!(user: users.sample, city: city, state: state, address_type: %w[home work].sample)
end

products = 200.times.map do |i|
  Product.create!(name: "Product #{i + 1}", category: categories.sample, supplier: suppliers.sample,
                  price: rand(100..150_000), stock: rand(0..500),
                  created_at: random_date(Date.new(2023, 1, 1), Date.new(2026, 8, 31)))
end

order_statuses = %w[pending confirmed processing shipped delivered cancelled]
orders = 1_000.times.map do
  Order.create!(user: users.sample, status: order_statuses.sample, total_amount: 0,
                ordered_at: random_date(Time.new(2024, 1, 1), Time.new(2026, 8, 31)))
end

orders.each do |order|
  total = 0
  products.sample(rand(1..5)).each do |product|
    quantity = rand(1..5)
    OrderItem.create!(order: order, product: product, quantity: quantity, unit_price: product.price)
    total += quantity * product.price
  end
  order.update!(total_amount: total)
end

payment_statuses = %w[pending successful successful successful failed refunded]
payment_methods = %w[card upi net_banking wallet]
orders.each do |order|
  next if rand < 0.10
  amount = rand < 0.05 ? order.total_amount + rand(100..5_000) : order.total_amount
  Payment.create!(order: order, amount: amount, status: payment_statuses.sample,
                  payment_method: payment_methods.sample,
                  paid_at: rand < 0.80 ? order.ordered_at + rand(1..72).hours : nil)
end

shipment_statuses = %w[pending processing shipped delivered cancelled]
orders.each do |order|
  next if rand < 0.20
  status = shipment_statuses.sample
  shipped_at = %w[shipped delivered].include?(status) ? order.ordered_at + rand(1..10).days : nil
  delivered_at = status == "delivered" ? shipped_at + rand(1..7).days : nil
  Shipment.create!(order: order, status: status, shipped_at: shipped_at, delivered_at: delivered_at)
end

review_comments = ["Excellent product", "Good quality", "Average product", "Could be better", "Very useful", "Not satisfied"]
1_500.times do
  Review.create!(user: users.sample, product: products.sample, rating: rand(1..5), comment: review_comments.sample,
                 created_at: random_date(Date.new(2024, 1, 1), Date.new(2026, 8, 31)))
end

Order.where(user: users[0]).find_each do |order|
  Payment.where(order: order).delete_all
  Shipment.where(order: order).delete_all
  OrderItem.where(order: order).delete_all
  order.delete
end
users[1].update!(salary: 500_000)
users[2..4].each { |user| user.update!(salary: 100_000) }
products[0].update!(stock: 0)
OrderItem.where(product: products[1]).delete_all

puts "\n======================================"
puts "DATABASE SEED COMPLETED"
puts "======================================"
puts "Departments : #{Department.count}"
puts "Users       : #{User.count}"
puts "Addresses   : #{Address.count}"
puts "Categories  : #{Category.count}"
puts "Suppliers   : #{Supplier.count}"
puts "Products    : #{Product.count}"
puts "Orders      : #{Order.count}"
puts "OrderItems  : #{OrderItem.count}"
puts "Payments    : #{Payment.count}"
puts "Shipments   : #{Shipment.count}"
puts "Reviews     : #{Review.count}"
puts "======================================"
