class Shipment < ApplicationRecord
  has_many :book_shipments
  belongs_to :user
end
