class InformationsController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :authenticate_user!, only: [:create, :new]

  def index
    @informations = Information.all
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

  private

  def information_params
    params.require(:information).permit(:title, :description, :user_id, photos: [])
  end

end
