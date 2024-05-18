class InformationsController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :authenticate_user!, only: [:create, :new, :edit, :update, :destroy]
  include Pundit

  def index
    @informations = Information.all
    authorize @informations
  end

  def show
    @information = Information.find(params[:id])
    authorize @information
  end

  def new
    @information = Information.new
    authorize @information
  end

  def create
    @information = Information.new(information_params)
    @information.user_id = current_user.id
    @information.photos.attach(params[:information][:photos])
    authorize @information
    if @information.save
      redirect_to informations_path, notice: 'Votre article a été crée avec succès.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @information = Information.find(params[:id])
    authorize @information
  end

  def update
    @information = Information.find(params[:id])
    authorize @information
    if @information.update(information_params)
      redirect_to informations_path, notice: 'Votre article a été mis à jour.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @information = Information.find(params[:id])
    authorize @information
    @information.destroy
    redirect_to informations_path, status: :see_other, notice: 'Votre article a été détruit.'
  end

  private

  def information_params
    params.require(:information).permit(:title, :description, :user_id, photos: [])
  end
end
