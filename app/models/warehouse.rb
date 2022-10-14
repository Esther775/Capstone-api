class Warehouse < ApplicationRecord
  has_many :inventories
  has_many :prints
end
