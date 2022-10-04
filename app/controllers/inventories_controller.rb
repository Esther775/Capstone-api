class InventoriesController < ApplicationController
  def index
    @inventories = Inventory.all

    render template: "inventories/index"
  end

  def show
    inventory = Inventory.where(warehouse_id: params[:id])

    render json: inventory.as_json
  end
end
