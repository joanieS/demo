class InstallationsController < ApplicationController

  before_filter :authenticate_user!, except: [:show]

  before_action :set_customer

  before_action :set_installation, only: [:show, :edit, :update, :destroy]

  def index
    @installations = Installation.where(customer_id: @customer.id)
  end

  #def show
  #  if request.format.json?
  #    render :show, status: :ok, location: installation_path
  #  else
  #    render :show
  #  end
  #end
  def show
    if request.format.json?
      @installation = Installation.find_by id: params[:id]
      @installation.beacons.each do |beacon|
        if beacon.content_type == "memories"
          beacon.content = get_audio_clips
        end
      end
      render :show, status: :ok, location: installation_path
    else
      authenticate_user!
      render action: "show"
    end
  end

  def new
    @installation = Installation.new
  end

  def create
    @installation = Installation.new(installation_params)
    set_customer_id
    respond_to do |format|
      if @installation.save
        format.html { redirect_to installation_path, notice: "Installation was successfully created." }
        format.json { render :show, status: :created, location: installation_path }
      else
        format.html { render :new }
        format.json { render json: @installation.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit; end

  def update
    respond_to do |format|
      if @installation.update(installation_params)
        format.html { redirect_to installation_path, notice: "Installation was successfully updated." }
        format.json { render :show, status: :ok, location: installation_path }
      else
        format.html { render :edit }
        format.json { render json: @installation.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @installation.destroy
    respond_to do |format|
      format.html { redirect_to installations_path, notice: "Installation was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

    def get_audio_clips
      s3 = AWS::S3.new(
        :access_key_id => Rails.application.secrets.AWS_ACCESS_KEY_ID,
        :secret_access_key => Rails.application.secrets.AWS_SECRET_ACCESS_KEY)
        
      audio_clips = s3.buckets['lufthouse-memories']

      audio_clip_URLs = Array.new

      audio_clips.objects.each do |f|
        audio_clip_URLs << "https://s3.amazonaws.com/lufthouse-memories/" + f.key
      end

      return audio_clip_URLs
    end

    def set_customer
      @customer = Customer.find_by id: params[:customer_id]
    end

    def set_installation
      @installation = @customer.installations.find(params[:id])
    end

    def set_customer_id
      @installation.customer_id = current_user.customer_id
    end

    def installation_params
      params.require(:installation).permit(:name, :group, :active)
    end

    # Paths
    
    def installations_path
      customer_installations_path(@customer)
    end

    def installation_path
      customer_installation_path(@customer, @installation)
    end
end
