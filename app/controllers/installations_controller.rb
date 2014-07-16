#Routes lufthouse.com/installations/customer1/installation1 should output all beacons from customer1, installation1
#Audio recording, record your voice, get it to lufthouse somehow

class InstallationsController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_customer
  before_action :set_installation, only: [:show, :edit, :update, :destroy]

  def index
    # only display installations belonging to current user
    @installations = Installation.where(customer_id: current_user.id)
  end

  def show
  end

  def new
    @installation = Installation.new
  end

  def create
    @installation = Installation.new(installation_params)
    @installation.customer_id = current_user.customer_id
    respond_to do |format|
      if @installation.save
        format.html { redirect_to customer_installation_path [@customer,@installation], notice: 'Installation was successfully created.' }
        format.json { render :show, status: :created, location: @installation }
      else
        format.html { render :new }
        format.json { render json: @installation.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @installation.update(installation_params)
        format.html { redirect_to @installation, notice: 'Installation was successfully updated.' }
        format.json { render :show, status: :ok, location: @installation }
      else
        format.html { render :edit }
        format.json { render json: @installation.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @installation.destroy
    respond_to do |format|
      format.html { redirect_to installations_url, notice: 'Installation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_installation
      if params[:id]
        @installation = Installation.find(params[:id])
      end
      if params[:name] && params[:beacon_id]
        @installation = Installation.find_by_name_and_beacon_id(params[:name], params[:beacon_id])
      end
    end

    def format_json

    end

    def set_customer
      @customer = Customer.find(current_user.customer_id)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def installation_params
      params.require(:installation).permit(:name)
    end
end
