class ShipmentController < ApplicationController
  def create
    shipment = Shipment.new(
      user_id: current_user.id,
      book_id: params[:book_id],
      from_warehouse_id: params[:from_warehouse_id],
      to_warehouse_id: params[:to_warehouse_id],
      quantity: params[:quantity],
    )

    if shipment.save
      render json: shipment.as_json
    else
      render json: errors.full_mmessages
    end
  end
end
