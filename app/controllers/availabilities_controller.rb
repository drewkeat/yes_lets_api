class AvailabilitiesController < ApplicationController
  before_action :set_availability, only: [:show, :update, :destroy]

  # GET /availabilities
  def index
    @availabilities = Availability.all

    render json: AvailabilitySerializer.new(@availabilities)
  end

  # GET /availabilities/1
  def show
    render json: AvailabilitySerializer.new(@availability)
  end

  # POST /availabilities
  def create
    @availability = Availability.new(availability_params)

    if @availability.save
      render json: AvailabilitySerializer.new(@availability), status: :created, location: @availability
    else
      render json: @availability.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /availabilities/1
  def update
    if @availability.update(availability_params)
      render json: AvailabilitySerializer.new(@availabilities)
    else
      render json: @availability.errors, status: :unprocessable_entity
    end
  end

  # DELETE /availabilities/1
  def destroy
    @availability.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_availability
      @availability = Availability.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def availability_params
      params.require(:availability).permit(:start, :end, :user_id)
    end
end
