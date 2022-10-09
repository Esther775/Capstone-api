class ShipmentController < ApplicationController
  def create
    if current_user
      shipment = Shipment.new(
        user_id: current_user.id,
        from_warehouse_id: params[:from_warehouse_id],
        to_warehouse_id: params[:to_warehouse_id],
        comment: params[:comment],
      )
      shipment.save

      params[:books].each do |individual_book|
        book = BookShipment.new(
          book_id: individual_book["book_id"],
          quantity: individual_book["quantity"],
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
    else
      render json: { message: "Please Log In" }, status: 401
    end
  end

  def index
    @shipments = Shipment.all.order("created_at DESC")
    render template: "shipments/index"

    # shipment = Shipment.where(user_id: current_user)
  end

  def update
    #find the shipment
    shipment = Shipment.find_by(id: params[:id])
    shipment.user_id = current_user.id
    shipment.to_warehouse_id = params[:to_warehouse_id]
    shipment.from_warehouse_id = params[:from_warehouse_id]

    #delete all books in shipment and reduce inventory accordingly

    shipment.book_shipments.each do |book|
      inventory = Inventory.find_by(warehouse_id: shipment.from_warehouse_id, book_id: book.book_id)
      inventory.current_inventory += book.quantity

      inventory.save

      inventory = Inventory.find_by(warehouse_id: shipment.to_warehouse_id, book_id: book.book_id)
      inventory.current_inventory -= book.quantity

      inventory.save
    end

    shipment.book_shipments.destroy_all

    #recreate books in shipment, adjust stock accordingly
    params[:books].each do |individual_book|
      book = BookShipment.new(
        book_id: individual_book["book_id"],
        quantity: individual_book["quantity"],
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

    shipment.comment = params[:comment]
    shipment.save
  end

  def show
    @shipment = Shipment.find_by(id: params[:id])

    render template: "shipments/show"
  end

  def destroy
    shipment = Shipment.find_by(id: params[:id])

    shipment.book_shipments.each do |book|
      inventory = Inventory.find_by(warehouse_id: shipment.from_warehouse_id, book_id: book.book_id)
      inventory.current_inventory += book.quantity

      inventory.save

      inventory = Inventory.find_by(warehouse_id: shipment.to_warehouse_id, book_id: book.book_id)
      inventory.current_inventory -= book.quantity

      inventory.save
    end

    shipment.destroy
    # shipment.save

    render json: { message: shipment }
  end
end
