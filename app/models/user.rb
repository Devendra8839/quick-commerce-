class User < ApplicationRecord
  belongs_to :department
  has_many :orders
end
