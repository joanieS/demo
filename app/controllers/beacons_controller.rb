class BeaconsController < InheritedResources::Base
  before_filter :authenticate_user!

  def create
    @beacon = Beacon.new(beacon_params)
    @installation = Installation.find(params[:installation_id])
    if @beacon.save
      redirect_to @beacon, notice: 'Beacon was successfully created.'
    else
       render action: 'new'
    end
  end

  private

  def beacon_params
    params.require(:beacon).permit(:minor_id, :content, :content_type, :audio, :content_image)
  end
end