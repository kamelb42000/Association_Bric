class BookingsController < ApplicationController

  def index
    @bookings = Booking.all.order(date: :desc) # Trie les réservations par ordre descendant de date
    @my_product_booked = Booking.joins(:product).where("products.user_id = ?", current_user.id)
  end

  def create
    @booking = Booking.new(booking_params)
    @booking.user_id = current_user.id
    @booking.date = Date.today
    if @booking.save
      # Marquer le produit comme réservé une fois que la réservation est créée avec succès
      @booking.product.update(reserved: true)
      redirect_to products_path, notice: "La réservation a été effectuée avec succès."
    else
      redirect_to products_path(@products), flash: {alert: "Action impossible, Vous ne pouvezréservez que 2 produits à la fois"}
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
    redirect_to bookings_path, notice: "La réservation'a pas été validée"
  end


  private

  def booking_params
    params.require(:booking).permit(:date, :user_id, :product_id, :product)
  end

end
