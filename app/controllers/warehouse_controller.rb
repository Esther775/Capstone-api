class WarehouseController < ApplicationController
  def index
    warehouse = Warehouse.all
    render json: warehouse.as_json
  end
end
