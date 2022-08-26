class CreateInventories < ActiveRecord::Migration[7.0]
  def change
    create_table :inventories do |t|
      t.integer :books_id
      t.integer :warehouse_id
      t.integer :current_inventory

      t.timestamps
    end
  end
end
