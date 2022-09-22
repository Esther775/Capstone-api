class AddCommentSectiontoShipmentTable < ActiveRecord::Migration[7.0]
  def change
    add_column :shipments, :comment, :string
  end
end
