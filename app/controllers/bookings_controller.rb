class BookingsController < ApplicationController

  def index
    @bookings = Booking.all
    @my_product_booked = Booking.joins(:product).where("products.user_id = ?", current_user.id)
  end

  def create
    @booking = Booking.new(booking_params)
    @booking.user_id = current_user.id
    if @booking.save
      # Marquer le produit comme réservé une fois que la réservation est créée avec succès
      @booking.product.update(reserved: true)
      redirect_to products_path, notice: "La réservation a été effectuée avec succès."
    else
      render :new, status: :unprocessable_entity
    end
  end


  def accept
    @booking = Booking.find(params[:id])
    @booking.accepted = true
    if @booking.save
      redirect_to bookings_path, notice: "La réservation a été validée avec succès"
    else
      redirect_to bookings_path
    end
  end

  def refuse
    @booking = Booking.find(params[:id])
    @booking.update(accepted: false)
    redirect_to bookings_path, notice: "La réservationn'a pas été validée"
  end


  private

  def booking_params
    params.require(:booking).permit(:date, :user_id, :product_id, :product)
  end

end
