class PlantBoardsController < ApplicationController
  before_action :set_plant_board, only: [ :show, :edit, :update, :destroy, :water ]
  def new
    @plant_board = current_user.plant_boards.build
  end

  def create
    @plant_board = current_user.plant_boards.build(plant_board_params)
    @plant_board.last_watered_on ||= Date.current

    if @plant_board.save
      redirect_to plant_boards_path
    else
      render :new
    end
  end

  def index
    @plant_boards = current_user.plant_boards.order(created_at: :desc)
  end

  def show
    @plants = @plant_board.plants.order(created_at: :desc)
  end

  def edit
  end


  def update
    if @plant_board.update(plant_board_params)
      redirect_to plant_boards_path
    else
      render :edit, status: :unprocessable_entity
    end
  end


  def destroy
    @plant_board.destroy!
    redirect_to plant_boards_path, status: :see_other
  end

  def water
    @plant_board.update!(last_watered_on: Date.current)
  end


  private

  def set_plant_board
    @plant_board = current_user.plant_boards.find(params[:id])
  end

  def plant_board_params
    params.require(:plant_board).permit(:plant_name, :body, :plant_board_image, :plant_board_image_cache, :watering_interval_days)
  end
end
