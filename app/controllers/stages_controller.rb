class StagesController < ApplicationController
  before_action :set_stage, only: [:show, :edit, :update, :destroy]

  def index
    @stages = Stage.all
  end

  def show
  end

  def new
    @stage = Stage.new
    @theaters = Theater.all
  end

  def create
    @stage = Stage.new(stage_params)
    if @stage.save
      redirect_to stages_path, notice: "公演情報を作成しました"
    else
      render :new
    end
  end

  def edit
    @theaters = Theater.all
  end

  def update
    @stage.update(stage_params)
    redirect_to stages_path, notice: "公演情報を更新しました"
  end

  def destroy
    @stage.destroy
    redirect_to stages_path
  end

  private
    def stage_params
      params.require(:stage).permit(:start_date, :end_date, :group, :theater_id)
    end

    def set_stage
      @stage = Stage.find(params[:id])
    end
end