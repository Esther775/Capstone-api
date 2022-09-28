class Book < ApplicationRecord
  has_many :inventories
  has_many :book_shipments
end
