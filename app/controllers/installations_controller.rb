class InstallationsController < ApplicationController

  before_filter :authenticate_user!, except: [:show]

  before_action :set_customer

  before_action :set_installation, only: [:show, :edit, :update, :destroy]

  def index
    @installations = Installation.where(customer_id: @customer.id)
  end

  def show
    if request.format.json?
      @installation.beacons.each do |beacon|
        if beacon.content_type == "memories"
          beacon.content = get_audio_clips
        end
        if beacon.content_type == "photo-gallery"
          beacon.content = get_photo_gallery(beacon.installation_id, beacon.minor_id)
        end
      end
      render action: "show"
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

      return audio_clip_URLs.shuffle
    end

    def get_photo_gallery(installation_id, minor_id)
      s3 = AWS::S3.new(
        :access_key_id => Rails.application.secrets.AWS_ACCESS_KEY_ID,
        :secret_access_key => Rails.application.secrets.AWS_SECRET_ACCESS_KEY)
        
      bucket_name = "Photo-Gallery-" + installation_id.to_s + "-" + minor_id.to_s
        
      photo_gallery_images = s3.buckets[bucket_name]

      photo_gallery_images_URLs = Array.new

      photo_gallery_images.objects.each do |f|
        photo_gallery_images_URLs << "https://s3.amazonaws.com/" + bucket_name + "/" + f.key
      end

      return photo_gallery_images_URLs
    end

    def set_customer
      @customer = Customer.find(params[:customer_id])
    end

    def set_installation
      @installation = @customer.installations.find(params[:id])
    end

    def set_customer_id
      @installation.customer_id = current_user.customer_id
    end

    def installation_params
      params.require(:installation).permit(:name, :group, :customer_id, :active, :image_url)
    end

    # Paths
    def installations_path
      customer_installations_path(@customer)
    end

    def installation_path
      customer_installation_path(@customer, @installation)
    end

end
