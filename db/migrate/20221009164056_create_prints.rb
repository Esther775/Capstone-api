class CreatePrints < ActiveRecord::Migration[7.0]
  def change
    create_table :prints do |t|
      t.integer :book_id
      t.integer :quantity
      t.integer :warehouse_id

      t.timestamps
    end
  end
end
