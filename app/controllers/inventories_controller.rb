class InventoriesController < ApplicationController
  def index
    @inventories = Inventory.all.order("created_at DESC")

    render template: "inventories/index"
  end

  def show
    inventory = Inventory.where(warehouse_id: params[:id])

    render json: inventory.as_json
  end
end
