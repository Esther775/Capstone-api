class RemoveBooKAndQUantityFromShipments < ActiveRecord::Migration[7.0]
  def change
    remove_column :shipments, :book_id
    remove_column :shipments, :quantity
  end
end
