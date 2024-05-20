class BookingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_booking, only: [:show, :accept, :refuse]
  include Pundit

  def index
    @bookings = Booking.all.order(date: :desc) # Trie les réservations par ordre descendant de date
    @my_product_booked = Booking.joins(:product).where("products.user_id = ?", current_user.id)
  end

  def create
    @booking = Booking.new(booking_params)
    @booking.user_id = current_user.id
    @booking.date = Date.today
    if @booking.save
      @booking.product.update(reserved: true)
      redirect_to products_path, notice: "La réservation a été effectuée avec succès."
    else
      redirect_to products_path, flash: { alert: "Action impossible, Vous ne pouvez réservez que 2 produits à la fois" }
    end
  end

  def show
    @booking = Booking.find(params[:id])
  end


  def accept
    authorize @booking, :accept?
    if @booking.update(accepted: true)
      redirect_to @booking, notice: "La réservation a été validée avec succès"
    else
      redirect_to @booking, alert: "La validation a échoué"
    end
  end

  def refuse
    authorize @booking, :refuse?
    if @booking.update(accepted: false)
      redirect_to @booking, notice: "La réservation a été refusée avec succès"
    else
      redirect_to @booking, alert: "Le refus a échoué"
    end
  end

  private

  def booking_params
    params.require(:booking).permit(:date, :user_id, :product_id, :product)
  end

  def set_booking
    @booking = Booking.find(params[:id])
  end
end
