class WarehouseController < ApplicationController
  def index
    warehouse = Warehouse.all
    render json: warehouse.as_json
  end

  def show
    warehouse = Warehouse.find_by(id: params[:id])
    render json: warehouse.as_json
  end
end
