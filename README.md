# 🚀 QuickCommerce — ActiveRecord + PostgreSQL Interview Practice

A hands-on **Ruby on Rails ActiveRecord + PostgreSQL** interview preparation project designed for developers with **4+ years of Ruby on Rails experience**.

The goal is not just to memorize ActiveRecord methods, but to understand how Rails queries translate into SQL and how PostgreSQL executes and optimizes those queries.

---

## 🎯 Project Goal

This project is designed to practice:

- Ruby on Rails ActiveRecord
- Rails Associations
- PostgreSQL
- Raw SQL
- SQL Joins
- Aggregations
- Subqueries
- CTEs
- Window Functions
- Query Optimization
- Indexes
- N+1 Query Problems
- Transactions
- Database Constraints
- Real-world business queries

### Core Principle

> **Every challenging problem should be solved twice:**

```text
Business Requirement
        │
        ├── ActiveRecord
        │
        └── PostgreSQL SQL
```

This helps build both:

```text
Rails Application Knowledge
+
Database/SQL Knowledge
```

---

# 🏗️ Application Domain

QuickCommerce represents a simplified e-commerce/order-management system.

The application contains:

```text
Department
    │
    └── Users
          │
          ├── Addresses
          │
          ├── Orders
          │     ├── OrderItems
          │     │      └── Products
          │     │             ├── Category
          │     │             └── Supplier
          │     │
          │     ├── Payment
          │     └── Shipment
          │
          └── Reviews
                 │
                 └── Products
```

---

# 🗄️ Database Schema

## Departments

```text
departments
-------------------------
id
name
created_at
updated_at
```

Relationship:

```ruby
Department has_many :users
```

---

## Users

```text
users
-------------------------
id
name
email
salary
department_id
status
created_at
updated_at
```

Relationships:

```ruby
User belongs_to :department, optional: true
User has_many :addresses
User has_many :orders
User has_many :reviews
User has_many :reviewed_products, through: :reviews
```

---

## Addresses

```text
addresses
-------------------------
id
user_id
city
state
address_type
created_at
updated_at
```

Relationship:

```ruby
Address belongs_to :user
```

---

## Categories

```text
categories
-------------------------
id
name
created_at
updated_at
```

Relationship:

```ruby
Category has_many :products
```

---

## Suppliers

```text
suppliers
-------------------------
id
name
created_at
updated_at
```

Relationship:

```ruby
Supplier has_many :products
```

---

## Products

```text
products
-------------------------
id
name
category_id
supplier_id
price
stock
created_at
updated_at
```

Relationships:

```ruby
Product belongs_to :category
Product belongs_to :supplier

Product has_many :order_items
Product has_many :orders, through: :order_items

Product has_many :reviews
Product has_many :reviewers, through: :reviews
```

---

## Orders

```text
orders
-------------------------
id
user_id
status
total_amount
ordered_at
created_at
updated_at
```

Relationships:

```ruby
Order belongs_to :user

Order has_many :order_items
Order has_many :products, through: :order_items

Order has_one :payment
Order has_one :shipment
```

---

## Order Items

```text
order_items
-------------------------
id
order_id
product_id
quantity
unit_price
created_at
updated_at
```

Relationships:

```ruby
OrderItem belongs_to :order
OrderItem belongs_to :product
```

---

## Payments

```text
payments
-------------------------
id
order_id
amount
status
payment_method
paid_at
created_at
updated_at
```

Relationship:

```ruby
Payment belongs_to :order
```

---

## Shipments

```text
shipments
-------------------------
id
order_id
status
shipped_at
delivered_at
created_at
updated_at
```

Relationship:

```ruby
Shipment belongs_to :order
```

---

## Reviews

```text
reviews
-------------------------
id
user_id
product_id
rating
comment
created_at
updated_at
```

Relationships:

```ruby
Review belongs_to :user
Review belongs_to :product
```

---

# 📊 Seed Data

The seed script creates realistic interview data.

Approximate dataset:

| Table | Records |
|---|---:|
| Departments | 6 |
| Users | 100 |
| Addresses | 150 |
| Categories | 10 |
| Suppliers | 20 |
| Products | 200 |
| Orders | 1,000 |
| Order Items | ~3,000 |
| Payments | ~900 |
| Shipments | ~800 |
| Reviews | 1,500 |

The dataset intentionally contains edge cases.

### Edge Cases

- Users without departments
- Users without orders
- Duplicate salaries
- Very high salaries
- Products with zero stock
- Products with no orders
- Orders without payments
- Orders without shipments
- Failed payments
- Refunded payments
- Payment amount mismatches
- Cancelled orders
- Multiple products per order
- Multiple addresses per user
- Different order dates
- Different product prices
- Different review ratings

These edge cases are intentional because they allow realistic interview questions.

---

# ⚙️ Setup

## Requirements

```text
Ruby
Rails
PostgreSQL
Bundler
```

Recommended:

```text
Ruby 3.x
Rails 8.x
PostgreSQL 14+
```

---

## Create Database

```bash
bin/rails db:create
```

---

## Run Migrations

```bash
bin/rails db:migrate
```

---

## Seed Database

```bash
bin/rails db:seed
```

---

## Reset Database

To completely recreate the practice database:

```bash
bin/rails db:reset
```

---

# 🔍 Verify Database

Open Rails console:

```bash
bin/rails console
```

Check:

```ruby
User.count
Order.count
Product.count
OrderItem.count
Payment.count
Shipment.count
Review.count
```

---

# 🐘 PostgreSQL Console

Open PostgreSQL through Rails:

```bash
bin/rails dbconsole
```

List tables:

```sql
\dt
```

Describe a table:

```sql
\d users
```

Describe orders:

```sql
\d orders
```

---

# 🧠 Interview Practice Rules

Each assignment should be solved in two ways.

### Part 1 — ActiveRecord

Example:

```ruby
User.where(status: "active")
```

### Part 2 — PostgreSQL

Equivalent SQL:

```sql
SELECT *
FROM users
WHERE status = 'active';
```

---

# 📚 Assignment Roadmap

## 🟢 Level 1 — ActiveRecord Fundamentals

### Assignment 01 — Find

Practice:

```ruby
find
find_by
find_by!
```

Questions:

- Find user by ID
- Find user by email
- Find user by multiple attributes
- Difference between `find` and `find_by`

---

### Assignment 02 — Filtering

Practice:

```ruby
where
where.not
or
not
```

Questions:

- Find active users
- Find users earning more than ₹100,000
- Find inactive users
- Find users without a department

---

### Assignment 03 — Ordering

Practice:

```ruby
order
limit
offset
```

Questions:

- Top 5 salaries
- Bottom 5 salaries
- Third-highest salary
- Latest 10 users

---

# 🟡 Level 2 — Aggregations

Practice:

```ruby
count
sum
average
minimum
maximum
group
having
```

Questions:

### Assignment 04

Find:

- Total users
- Average salary
- Highest salary
- Lowest salary
- Total order revenue

---

### Assignment 05

Find salary statistics per department.

Return:

```text
department
employee_count
average_salary
highest_salary
lowest_salary
```

---

### Assignment 06

Find departments having more than 5 employees.

---

# 🟡 Level 3 — Associations

### Assignment 07

Practice:

```ruby
belongs_to
has_many
has_one
has_many :through
```

Questions:

- Users with orders
- Orders belonging to users
- Products belonging to categories
- Products belonging to suppliers
- Products purchased by a user

---

### Assignment 08

Find users who have never placed an order.

---

### Assignment 09

Find products that have never been ordered.

---

### Assignment 10

Find users who have purchased more than 5 orders.

---

# 🟠 Level 4 — JOINs

Practice:

```ruby
joins
left_joins
```

SQL:

```sql
INNER JOIN
LEFT JOIN
RIGHT JOIN
```

Questions:

- User + department
- User + orders
- Order + payment
- Product + category
- Product + supplier
- Users without orders

---

# 🟠 Level 5 — ActiveRecord Loading

### Assignment 11 — N+1

Analyze:

```ruby
users = User.all

users.each do |user|
  puts user.orders.count
end
```

Identify the N+1 query.

---

### Assignment 12

Compare:

```ruby
includes
preload
eager_load
joins
```

Understand the SQL generated by each.

---

### Assignment 13

Optimize:

```ruby
orders.each do |order|
  puts order.user.name
  puts order.products.pluck(:name)
end
```

---

# 🔴 Level 6 — Salary Challenges

### Assignment 14

Find the highest salary.

---

### Assignment 15

Find the second-highest salary.

---

### Assignment 16

Find the third-highest salary.

---

### Assignment 17

Find the third-highest **distinct** salary.

---

### Assignment 18

Find the highest-paid employee in every department.

---

### Assignment 19

Find the second-highest-paid employee in every department.

---

### Assignment 20

Find employees earning above their department's average salary.

---

# 🔴 Level 7 — Subqueries

Practice:

```sql
SELECT
WHERE
EXISTS
NOT EXISTS
```

Questions:

### Assignment 21

Find users whose spending is greater than average user spending.

---

### Assignment 22

Find products priced above their category average.

---

### Assignment 23

Find users who have placed at least one order.

---

### Assignment 24

Find users who have never placed an order.

---

# 🔴 Level 8 — Window Functions

Practice:

```sql
ROW_NUMBER()
RANK()
DENSE_RANK()
```

### Assignment 25

Rank employees by salary.

---

### Assignment 26

Rank employees by salary within each department.

---

### Assignment 27

Find top 3 employees in every department.

---

### Assignment 28

Find second-highest salary per department.

---

### Assignment 29

Find top 3 products in every category by revenue.

---

# 🔥 Level 9 — Business Problems

### Assignment 30 — Customer Lifetime Value

Find the top 10 customers by total spending.

Return:

```text
user_id
user_name
total_spending
```

---

### Assignment 31 — Abandoned Customers

Find customers who:

- Have placed an order previously
- Have not ordered in the last 90 days

---

### Assignment 32 — Repeat Customers

Find customers who placed orders in at least 3 different months.

---

### Assignment 33 — Payment Mismatch

Find orders where:

```text
order.total_amount != payment.amount
```

Only include successful payments.

---

### Assignment 34 — Dead Inventory

Find products that:

```text
stock > 0
```

but have not been ordered in the last 180 days.

---

### Assignment 35 — Product Revenue

Return:

```text
product_name
total_quantity_sold
total_revenue
```

---

# 🔥 Level 10 — Advanced PostgreSQL

### Assignment 36

Find the top 3 customers by revenue for every month.

Concepts:

```text
GROUP BY
Window Functions
CTE
```

---

### Assignment 37

Find the top 3 products in every category.

---

### Assignment 38

Find each user's first order.

---

### Assignment 39

Find each user's latest order.

---

### Assignment 40

Find users whose latest order was cancelled.

---

### Assignment 41

Find customers who purchased Product A but never Product B.

---

### Assignment 42

Find customers who purchased every product in a category.

---

# 🚀 Level 11 — PostgreSQL Performance

### Assignment 43 — EXPLAIN

Analyze:

```sql
EXPLAIN
SELECT *
FROM orders
WHERE user_id = 10;
```

---

### Assignment 44 — EXPLAIN ANALYZE

Compare query execution before and after creating an index.

---

### Assignment 45 — Index Design

Determine appropriate indexes for:

```text
users.department_id
orders.user_id
orders.ordered_at
orders.status
order_items.order_id
order_items.product_id
payments.order_id
```

---

### Assignment 46 — Composite Index

Determine whether this index would help:

```sql
CREATE INDEX idx_orders_status_ordered_at
ON orders(status, ordered_at);
```

Explain why.

---

# 🔥 Level 12 — Senior Rails Interview

Practice explaining:

### ActiveRecord

```text
find
find_by
where
pluck
select
distinct
joins
left_joins
includes
preload
eager_load
merge
group
having
scope
class methods
```

### PostgreSQL

```text
JOIN
GROUP BY
HAVING
Subqueries
CTE
EXISTS
NOT EXISTS
CASE
COALESCE
Window Functions
Indexes
EXPLAIN ANALYZE
Transactions
Locks
Constraints
```

---

# 🧪 Interview Simulation

The final phase should simulate an actual interview.

The interviewer gives a business requirement.

Example:

> Find the third-highest salary.

Candidate answers:

```ruby
# ActiveRecord
```

and:

```sql
-- PostgreSQL
```

Then interviewer changes the requirement:

> What if multiple employees have the same salary?

Then:

> Now find the third-highest salary in each department.

Then:

> Now return employee name and department name.

Then:

> Your users table contains 50 million records. How would you optimize this?

The candidate must explain:

```text
ActiveRecord
↓
Generated SQL
↓
PostgreSQL execution
↓
Indexes
↓
EXPLAIN ANALYZE
↓
Performance
```

---

# 📈 Difficulty Levels

| Level | Focus |
|---|---|
| 🟢 Beginner | ActiveRecord basics |
| 🟡 Intermediate | Associations + Aggregations |
| 🟠 Advanced | JOINs + N+1 |
| 🔴 Expert | Subqueries + Window Functions |
| 🔥 Senior | Complex business queries |
| 🚀 Production | Optimization + PostgreSQL |

---

# 🎯 Final Objective

By completing this project, you should be able to confidently answer questions such as:

```text
How does ActiveRecord generate SQL?

What is the difference between joins and includes?

How do you solve N+1?

How do you find the third-highest salary?

How do you handle duplicate salaries?

How do you find the top N records per group?

When should you use a subquery?

When should you use a CTE?

What is the difference between RANK and DENSE_RANK?

How do you optimize a slow query?

How do you decide which index to create?

How do you inspect a PostgreSQL execution plan?

How do Rails associations translate into SQL?

How would your query behave with 10 million or 50 million records?
```

---

# 🏆 Success Criteria

You are ready for a senior Rails + PostgreSQL interview when you can:

- Write ActiveRecord without memorizing blindly
- Convert ActiveRecord to SQL mentally
- Write complex PostgreSQL queries independently
- Explain JOIN behavior
- Identify N+1 queries
- Choose `includes`, `preload`, `eager_load`, or `joins`
- Solve ranking problems using window functions
- Handle NULL values correctly
- Use `GROUP BY` and `HAVING`
- Write subqueries and CTEs
- Design useful indexes
- Read `EXPLAIN ANALYZE`
- Discuss query performance
- Explain database constraints
- Reason about transactions and concurrency
- Solve unfamiliar business requirements

---

## 💡 Practice Philosophy

Don't memorize the solution.

For every problem, ask yourself:

```text
1. What is the business requirement?
2. Which tables contain the required data?
3. What relationships exist?
4. Do I need JOIN?
5. Do I need aggregation?
6. Do I need a subquery?
7. Do I need a window function?
8. Can ActiveRecord express this cleanly?
9. What SQL will ActiveRecord generate?
10. Will PostgreSQL execute it efficiently?
11. Which indexes could help?
12. What happens with NULL / duplicate / missing data?
```

> **The goal is to become a Rails developer who understands the database, not just a developer who knows ActiveRecord syntax.**