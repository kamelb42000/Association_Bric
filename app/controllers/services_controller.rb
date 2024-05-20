class ServicesController < ApplicationController

  def index
    @services = Service.all
  end

  def show
    @service = Service.find(params[:id])
  end

  def new
    @service = Service.new
  end

  def create
    @service = Service.new(service_params)
    @service.user_id = current_user.id
    if @service.save
      return redirect_to services_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @service = Service.find(params[:id])
  end

  def update
    @service = Service.find(params[:id])
    if @service.update(service_params)
      redirect_to services_path, flash: {alert: "La réservation a été modifiée avec succès"}
    else
      render :edit
    end
  end

  def destroy
    @service = Service.find(params[:id])
    @service.destroy
    redirect_to services_path, status: :see_other
  end

  def validate
    @service = Service.find(params[:id])
    authorize @service, :validate?  # Utilise la méthode validate? de la politique
    if @service.update(status: "Accepté")
      redirect_to @service, notice: "La réservation a été acceptée avec succès."
    else
      redirect_to @service, alert: "La réservation n'a pas pu être acceptée."
    end
  end

  def refuse
    @service = Service.find(params[:id])
    authorize @service, :refuse?
    if @service.update(status: "Refusé")
      redirect_to @service, notice: "La réservation a été refusée avec succès."
    else
      redirect_to @service, alert: "Le refus a échoué."
    end
  end


  private

  def service_params
    params.require(:service).permit(:first_name, :last_name, :address, :phone_number, :date, :description, :user_id)
  end

end
