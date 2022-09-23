class CreateBookShipments < ActiveRecord::Migration[7.0]
  def change
    create_table :book_shipments do |t|
      t.integer :book_id
      t.integer :shipment_id
      t.integer :quantity
      t.timestamps
    end
  end
end
