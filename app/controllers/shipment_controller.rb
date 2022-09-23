class ShipmentController < ApplicationController
  def create
    shipment = Shipment.new(
      user_id: current_user.id,
      from_warehouse_id: params[:from_warehouse_id],
      to_warehouse_id: params[:to_warehouse_id],
      comment: params[:comment],
    )
    shipment.save

    params[:book_id].each do |individual_book|
      book = BookShipment.new(
        book_id: individual_book,
        quantity: params[:quantity],
        shipment_id: shipment.id,
      )
      book.save

      inventory = Inventory.find_by(warehouse_id: shipment.from_warehouse_id, book_id: book.book_id)
      inventory.current_inventory -= book.quantity

      inventory.save

      inventory = Inventory.find_by(warehouse_id: shipment.to_warehouse_id, book_id: book.book_id)
      inventory.current_inventory += book.quantity

      inventory.save
    end

    books_in_shipment = BookShipment.where(shipment_id: shipment.id)

    render json: { shipment: shipment.as_json, books: books_in_shipment.as_json }
    #Right now I am nont renndering the inventory bc I dont think its needed in the shipments create
  end

  #How do I put this in a conditional so that the the shipment will only create if all peices go through? Because I need to shipment.save before book_shipment.new, because I need the shipment.id

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

  def show
    shipment = Shipment.find_by(id: params[:id])

    render json: shipment
  end
end
