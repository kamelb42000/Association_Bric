class MembersController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  include Pundit

  def index
    @members = Member.all
    @bookings = Booking.all
    @services = Service.all
    authorize @members
  end

  def show
    @member = Member.find(params[:id])
    @bookings = Booking.none
    @services = Service.none
    authorize @member
  end

  def new
    @member = Member.new
    authorize @member
  end

  def create
    @member = Member.new(member_params)
    authorize @member
    if @member.save
      redirect_to members_path, notice: "L'adhérent a été créé avec succès."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @member = Member.find(params[:id])
    authorize @member
  end

  def update
    @member = Member.find(params[:id])
    authorize @member
    if @member.update(member_params)
      redirect_to members_path, notice: "L'adhérent a été mis à jour avec succès."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @member = Member.find(params[:id])
    authorize @member
    if @member.destroy
      redirect_to members_path, notice: "L'adhérent a été supprimé avec succès.", status: :see_other
    else
      redirect_to members_path, alert: "La suppression de l'adhérent a échoué."
    end
  end

  private

  def member_params
    params.require(:member).permit(:first_name, :last_name, :address, :phone_number, :email, :membership_number, :photo)
  end

  def set_user
    @user = current_user
  end
end
