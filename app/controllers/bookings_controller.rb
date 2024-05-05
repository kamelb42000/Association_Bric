class BookingsController < ApplicationController

  def index
    @bookings = Booking.all
    @my_product_booked = Booking.joins(:product).where("stuffs.user_id = ?", current_user.id)
  end


  private

  def booking_params
    params.require(:booking).permit(:date, :user_id, :stuff_id)
  end

end
