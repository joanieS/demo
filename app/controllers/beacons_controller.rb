class BeaconsController < InheritedResources::Base
  before_filter :authenticate_user!

  def create
    @beacon = Beacon.new(beacon_params)

    if @beacon.save
      redirect_to @beacon, notice: 'Beacon was successfully created.'
     else
       render action: 'new'
    end
  end

   private

  def friend_params
    params.require(:friend).permit(:installation_id, :minor_id, :content, :content_type, :audio, :content_image)
  end
end