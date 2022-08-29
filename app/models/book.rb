class Book < ApplicationRecord
  has_many :inventories
  has_many :shipments
end
