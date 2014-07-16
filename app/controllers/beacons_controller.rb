class BeaconsController < InheritedResources::Base
  
  before_action :authenticate_user!

  before_action :set_customer_and_installation

  before_action :set_beacon, only: [:show, :edit, :destroy]

  def show; end

  def create
    @beacon = Beacon.new(beacon_params)
    set_beacon_installation_id
    if @beacon.save
      redirect_to customer_installation_beacon_path(@customer,@installation, @beacon), notice: 'Beacon was successfully created.'
    else
      render action: 'new'
    end
  end

  def destroy
    @beacon.destroy
    respond_to do |format|
      format.html { redirect_to customer_installation_path(@customer, @installation),
        notice: 'Customer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_customer_and_installation
    @customer = Customer.find(params[:customer_id])
    @installation = Installation.find(params[:installation_id])
  end

  def set_beacon
    @beacon = Beacon.find(params[:id])
  end

  def set_beacon_installation_id
    @beacon.installation_id = @installation.id
  end

  def beacon_params
    params.require(:beacon).permit(
      :minor_id, :major_id, :latitude, :longitude, :content, :content_type, :audio, :content_image
    )
  end
end