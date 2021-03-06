module Api
  module V1    
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
              beacon.content = ["https://s3.amazonaws.com/lufthouseawsbucket/beacons/content_images/000/000/092/original/euclidave-1910.jpg", "https://s3.amazonaws.com/lufthouseawsbucket/beacons/content_images/000/000/092/original/1-ArcadeSuperior_Start_Here.jpg"]
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
        set_image_url
        respond_to do |format|
          if @installation.save
            format.html { redirect_to installation_path, notice: "Installation was successfully created." }
            format.json { render :show, status: :created, location: installation_path }
          else
            unprocessable(@installation.errors)
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
            unprocessable(@installation.errors)
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

      # def get_audio_files
      #   s3 = AWS::S3.new(
      #     :access_key_id => Rails.application.secrets.AWS_ACCESS_KEY_ID,
      #     :secret_access_key => Rails.application.secrets.AWS_SECRET_ACCESS_KEY)


        
      #   audio_files = s3.buckets['lufthouseawsbucket'].objects.with_prefix(prefix).collect(&:key)



      # end

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
          params.require(:installation).permit(
            :name, :group, :customer_id, :active, :image_url, :image
            )
        end

        def set_image_url
          if @installation.image_file_name != nil
            @installation.image_url = @installation.image.url
          end
        end

        # Paths
        def installations_path(customer)
          customer_installations_path(customer)
        end

        def installation_path
          customer_installation_path(@customer, @installation)
        end

    end
   end 
end