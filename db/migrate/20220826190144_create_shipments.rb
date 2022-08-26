class CreateShipments < ActiveRecord::Migration[7.0]
  def change
    create_table :shipments do |t|
      t.integer :user_id
      t.integer :book_id
      t.string :from_warehouse_id
      t.string :to_warehouse_id
      t.integer :quantity

      t.timestamps
    end
  end
end
