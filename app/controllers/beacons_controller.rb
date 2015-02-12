class BeaconsController < ApplicationController
  include BeaconsHelper
  
  before_action :authenticate_user!

  before_action :set_customer_and_installation

  before_action :set_beacon, only: [:show, :edit, :update, :destroy]


  def show
    set_beacon_audio(@beacon)
    if request.format.json?
      format.json { render :show, status: :ok, location: beacon_path }
    end
    @hash = Gmaps4rails.build_markers(@beacon) do |beacon, marker|
      marker.lat beacon.latitude
      marker.lng beacon.longitude
    end
  end

  def new
    @beacon = Beacon.new
  end

  def create
    @beacon = Beacon.new(beacon_params)
    set_beacon_installation_id_and_uuid
    set_beacon_lat_and_long

    respond_to_create(@beacon, "beacon")
  end

  def update
    respond_to_update(@beacon, "beacon")
  end

  # def destroy
  #   @beacon.destroy
  #   respond_to_destroy(@beacon, "beacon")
  # end
  def destroy
    @beacon.destroy
    respond_to do |format|
      format.html { redirect_to installation_path, notice: 'Customer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


end
