class BeaconsController < InheritedResources::Base
  before_filter :authenticate_user!

  def create
    @beacon = Beacon.new(beacon_params)
    @installation = Installation.find(params[:installation_id])
    if @beacon.save
      redirect_to installation_beacon_path(@installation, @beacon), notice: 'Beacon was successfully created.'
    else
       render action: 'new'
    end
  end

  def show
    @installation = Installation.find(params[:installation_id])
    @beacon = Beacon.find(params[:id])
  end

  private

  def beacon_params
    params.require(:beacon).permit(:minor_id, :content, :content_type, :audio, :content_image)
  end
end