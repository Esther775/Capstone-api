class ShipmentController < ApplicationController
  def create
    shipment = Shipment.new(
      user_id: current_user.id,
      book_id: params[:book_id],
      from_warehouse_id: params[:from_warehouse_id],
      to_warehouse_id: params[:to_warehouse_id],
      quantity: params[:quantity],
      comment: params[:comment],
    )

    if shipment.save
      inventory = Inventory.find_by(warehouse_id: shipment.from_warehouse_id, book_id: shipment.book_id)
      inventory.current_inventory -= shipment.quantity
      inventory.save

      inventory = Inventory.find_by(warehouse_id: shipment.to_warehouse_id, book_id: shipment.book_id)
      inventory.current_inventory += shipment.quantity
      inventory.save

      render json: shipment.as_json
    else
      render json: shipment.errors.full_messages
    end
  end

  def index
    shipment = Shipment.all.order("created_at DESC")
    # shipment = Shipment.where(user_id: current_user)

    render json: shipment
  end

  def update
    shipment = Shipment.find_by(id: params[:id])
    shipment.user_id = current_user.id
    shipment.book_id = params[:book_id]
    shipment.to_warehouse_id = params[:to_warehouse_id]
    shipment.from_warehouse_id = params[:from_warehouse_id]
    shipment.quantity = params[:quantity]

    if shipment.save
      render json: shipment
    else
      render json: shipment.errors.full_messages
    end
  end

  def show
    shipment = Shipment.find_by(id: params[:id])

    render json: shipment
  end
end
