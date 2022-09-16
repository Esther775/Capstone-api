class InventoriesController < ApplicationController
  def show
    inventory = Inventory.where(warehouse_id: params[:id])

    render json: inventory.as_json
  end
end
