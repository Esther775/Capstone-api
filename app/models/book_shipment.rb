class BookShipment < ApplicationRecord
  belongs_to :shipment
  belongs_to :book
end
