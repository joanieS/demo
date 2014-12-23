class InstallationsController < ApplicationController

  before_filter :authenticate_user!, except: [:show]

  before_action :set_customer

  before_action :set_installation, only: [:show, :edit, :update, :destroy]

  def index
    @installations = Installation.where(:customer_id => @customer.id)
    @active_installations = Installation.where(:customer_id => @customer.id, :active => true)
  end

  def show
    set_image_url
    if request.format.json?
      @installation.beacons.each do |beacon|

        if beacon.content_type == "memories"
          beacon.content = get_audio_clips
        end
        if beacon.content_type == "photo-gallery"
          @current_beacon_id = "%03d" % beacon.id
          beacon.content = get_photo_gallery
        end
        if beacon.audio_file_name != nil && beacon.audio_file_name != "/audios/original/missing.png"
          beacon.audio_url = beacon.audio.url
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

    record_beacon_id = Beacon.where(:installation_id => @installation.id).where(:content_type => 'record-audio').first.id

    prefix = "#{@customer.id}" + '/' + "#{@installation.id}" + '/' + "#{record_beacon_id}"

    audio_clips = s3.buckets['lufthouse-memories'].objects.with_prefix(prefix).collect(&:key)

    audio_clip_URLs = Array.new

    unless audio_clips == []
      audio_clips.each do |f|
        audio_clip_URLs << "https://s3.amazonaws.com/lufthouse-memories/" + f
      end
    end

    return audio_clip_URLs.shuffle

  end

  def get_photo_gallery
    s3 = AWS::S3.new(
      :access_key_id => Rails.application.secrets.AWS_ACCESS_KEY_ID,
      :secret_access_key => Rails.application.secrets.AWS_SECRET_ACCESS_KEY)
    aws_installation_id = "%03d" % @installation.id
    prefix = "beacons/content_images/000/000/" + "#{@current_beacon_id}" + "/original"
    default_prefix = "installations/images/000/000/" + "#{aws_installation_id}" + "/original/"


    photo_gallery_images = s3.buckets['lufthouseawsbucket'].objects.with_prefix(prefix).collect(&:key)

    if photo_gallery_images == []
      binding.pry
      photo_gallery_images = s3.buckets['lufthouseawsbucket'].objects.with_prefix(default_prefix).collect(&:key)
    end
    
    photo_gallery_images_URLs = Array.new

      photo_gallery_images.each do |f|
        photo_gallery_images_URLs << "https://s3.amazonaws.com/lufthouseawsbucket/" + f
      end

      if photo_gallery_images_URLs == []
        photo_gallery_images_URLs = ["#{@installation.image_url}"]
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

    def set_image_url
      if @installation.image_file_name != nil
        @installation.image_url = @installation.image.url
      end
    end

    def installation_params
      params.require(:installation).permit(
        :name, :group, :customer_id, :active, :image_url, :image
        )
    end

    # Paths
    def installations_path
      customer_installations_path(@customer)
    end

    def installation_path
      customer_installation_path(@customer, @installation)
    end

end
