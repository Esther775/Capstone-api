class PrintsController < ApplicationController
  def index
    all_prints = Print.all

    render json: all_prints.as_json
  end

  def create
    new_print = Print.new(
      user_id: current_user.id,
      book_id: params[:book_id],
      quantity: params[:quantity],
      warehouse_id: params[:warehouse_id],
    )
    new_print.save

    inventory = Inventory.find_by(warehouse_id: new_print.warehouse_id, book_id: new_print.book_id)
    inventory.current_inventory += new_print.quantity

    inventory.save

    render json: { message: new_print.as_json }
  end

  def show
    this_print = Print.find_by(id: params[:id])

    render json: this_print.as_json
  end

  def update
    this_print = Print.find_by(id: params[:id])
    this_print.quantity = params[:quantity]
    this_print.book_id = params[:book_id]
    this_print.warehouse_id = params[:warehouse_id]

    this_print.save

    render json: this_print.as_json
  end

  def destroy
    this_print = Print.find_by(id: params[:id])

    inventory = Inventory.find_by(warehouse_id: this_print.warehouse_id, book_id: this_print.book_id)
    inventory.current_inventory -= this_print.quantity

    inventory.save
    this_print.destroy
    render json: { message: "destroyed " }
  end
end
