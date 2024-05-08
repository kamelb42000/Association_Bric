class BookingsController < ApplicationController

  def index
    @bookings = Booking.all
    @my_product_booked = Booking.joins(:product).where("products.user_id = ?", current_user.id)
  end

  def create
    @booking = Booking.new(booking_params)
    @booking.user_id = current_user.id
    if @booking.save
      redirect_to products_path, notice: "La réservation a été effectuée avec succès."
    else
      render :new, status: :unprocessable_entity
    end
  end




  private

  def booking_params
    params.require(:booking).permit(:date, :user_id, :product_id, :product)
  end

end
