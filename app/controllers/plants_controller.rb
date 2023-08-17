class PlantsController < ApplicationController

  # GET /plants
  def index
    plants = Plant.all
    render json: plants
  end

  # GET /plants/:id
  def show
    plant = find_plant_by_id
    render json: plant
  end

  # POST /plants
  def create
    plant = Plant.create(plant_params)
    render json: plant, status: :created
  end

  def update 
    plant = find_plant_by_id
    if plant
      plant.update(params.permit(:is_in_stock))
      render json: plant
    else 
      render_not_found
    end
  end

  def destroy
    plant = find_plant_by_id
    if plant
      plant.destroy
      head :no_content
    else
      render_not_found
    end
  end

  private

  def plant_params
    params.permit(:name, :image, :price, :is_in_stock)
  end

  def find_plant_by_id
    Plant.find_by(id: params[:id])
  end

  def render_not_found
    render json: {error: "Plant not found"}, status: :not_found
  end
   
end
