class InformationsController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :authenticate_user!, only: [:create, :new]

  def index
    @informations = Information.all
  end

  def show
    @information = Information.find(params[:id])
  end

  def new
    @information = Information.new
  end

  def create
    @information = Information.new(information_params)
    @information.user_id = current_user.id
    @information.photos.attach(params[:information][:photos])
    if @information.save
      return redirect_to informations_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @information = Information.find(params[:id])
  end

  def update
    @information = Information.find(params[:id])
    if @information.update(information_params)
    redirect_to informations_path(@informations), flash: {alert: "L'article a été modifié avec succès"}
    else
      render :edit
    end
  end

  def destroy
    @information = Information.find(params[:id])
    @information.destroy
    redirect_to informations_path, status: :see_other
  end


  private

  def information_params
    params.require(:information).permit(:title, :description, :user_id, photos: [])
  end

end
