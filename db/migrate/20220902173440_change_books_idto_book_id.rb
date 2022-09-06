class ChangeBooksIdtoBookId < ActiveRecord::Migration[7.0]
  def change
    rename_column :inventories, :books_id, :book_id
  end
end
