class BeaconsController < InheritedResources::Base
  before_filter :authenticate_user!
  before_filter :set_installation

  def create
    @beacon = Beacon.new(beacon_params)
    # installation local variable is not set here. Following code pasted into _form view to make it work
    @beacon.installation_id = @installation.id
    if @beacon.save
      # redirect to beacon show page on successful save
      redirect_to installation_beacon_path(@installation, @beacon), notice: 'Beacon was successfully created.'
    else
      render action: 'new'
    end
  end

  def show
    @beacon = Beacon.find(params[:id])
  end

  private
    def set_installation
      @installation = Installation.find(params[:installation_id])
    end

    def beacon_params
      params.require(:beacon).permit(:minor_id, :content, :content_type, :audio, :content_image)
    end
end