class HangtimesController < ApplicationController
  before_action :set_hangtime, only: [:show, :update, :destroy]

  # GET /hangtimes
  def index
    @hangtimes = Hangtime.all

    render json: HangtimeSerializer.new(@hangtimes)
  end

  # GET /hangtimes/1
  def show
    render json: HangtimeSerializer.new(@hangtime)
  end

  # POST /hangtimes
  def create
    @hangtime = Hangtime.new(hangtime_params)

    if @hangtime.save
      render json: HangtimeSerializer.new(@hangtime), status: :created, location: @hangtime
    else
      render json: @hangtime.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /hangtimes/1
  def update
    if @hangtime.update(hangtime_params)
      render json: HangtimeSerializer.new(@hangtime)
    else
      render json: @hangtime.errors, status: :unprocessable_entity
    end
  end

  # DELETE /hangtimes/1
  def destroy
    @hangtime.destroy
    render json: HangtimeSerializer.new(@hangtime)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_hangtime
      @hangtime = Hangtime.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def hangtime_params
      params.require(:hangtime).permit(:start, :end)
    end
end
