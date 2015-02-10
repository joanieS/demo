module ApplicationHelper

	def total_installations(customer)
		customer.installations.where(:active => true).count
	end

  def total_beacons(customer)
    customer.beacons.count
  end

  def current_state(object)
    object.active ? "Active" : "Inactive"    
  end

  def display_beacon_description(beacon)
    beacon.description ? beacon.description : "None."
  end

  def sign_in_page?(request)
    request.path_info == "/users/sign_in" ? " hide" : ""
  end

  def sign_up_page?(request)
    request.path_info == "/users/sign_up" ? " hide" : ""
  end

  def current_class_about?(request)
    request.path_info == "/" ? "current" : ""
  end

  def current_class_installations?(request)
    request.path_info =~ /customers+\/[0-9]+\/installations(\/[A-Za-z0-9\/]+)?/ ? "current" : ""
  end

  def current_class_account?(request)
    request.path_info =~ /customers\/[0-9]+(\/edit)?$/ ? "current" : ""
  end

  def current_class_new_customer?(request)
    request.path_info =~ /customers\/new$/ ? "current" : ""
  end

  def current_class_existing_customer?(request)
    request.path_info =~ /users\/[0-9]+\/edit$/ ? "current" : ""
  end

  def current_page_installation?(request)
    request.path_info =~ /customers+\/[0-9]+\/installations\/([0-9]+(\/edit)?|new)$/ ? true : false    
  end

  def current_page_metrics?(request)
    request.path_info == "/metrics" ? "current" : ""
  end

  def current_page_beacon?(request)
    if (request.path_info =~ /customers+\/[0-9]+\/installations\/[0-9]+\/beacons\/([0-9]+|new)$/) || (request.path_info =~ /customers+\/[0-9]+\/installations\/[0-9]+\/edit$/)
      true 
    else
      false
    end    
  end

  def current_page_beacon_edit?(request)
    request.path_info =~ /customers+\/[0-9]+\/installations\/[0-9]+\/beacons\/[0-9]+\/edit$/ ? true : false    
  end

  # Coordinates

  def check_coordinates(object)
    !(object.latitude.nil? || object.longitude.nil?)
  end

  def cardinalized_latitude(object)
    object.latitude > 0 ? raw("#{object.latitude}&deg; N") : raw("#{object.latitude.abs}&deg; S")
  end

  def cardinalized_longitude(object)
    object.longitude > 0 ? raw("#{object.longitude}&deg; E") : raw("#{object.longitude.abs}&deg; W")
  end

  def set_s3

    @s3 = AWS::S3.new(
      :access_key_id => Rails.application.secrets.AWS_ACCESS_KEY_ID,
      :secret_access_key => Rails.application.secrets.AWS_SECRET_ACCESS_KEY)
  end

  def current_installation(beacon)
    @installation = Installation.find(beacon.installation_id)
  end

  def respond_to_destroy(model, name)
    define_by_name(model, name)
    respond_to do |format|
      format.html { redirect_to @destroy_url, notice: "#{name}"+" was successfully destroyed."  }
      format.json { head :no_content }
    end
  end

  def respond_to_create(model, name)

    define_by_name(model, name)

    respond_to do |format|
      if model.save
        format.html { redirect_to @url, notice: "#{name}"+" was successfully created." }
        format.json { render :show, status: :created, location: @url }
      else
        format.html { render :new }
        format.json { render json: model.errors, status: :unprocessable_entity }
      end
    end
  end

  def respond_to_update(model, name)

  define_by_name(model, name)

    respond_to do |format|
      if model.update(@params_name)
        format.html { redirect_to @url, notice: "#{name}"+" was successfully updated." }
        format.json { render :show, status: :ok, location: @url }
      else
        format.html { render :edit }
        format.json { render json: model.errors, status: :unprocessable_entity }
      end
    
    end

  end

  def define_by_name(model, name)
    case name
    when "customer"
      @params_name = customer_params
      @url = @customer
      @destroy_url = customers_url
    when "installation"
      @params_name = installation_params
      @url = installation_path
      @destroy_url = installations_path
    when "beacon"
      @params_name = beacon_params
      @url = beacon_path
      @destroy_url = installation_path
    when "user"
      @params_name = user_params
      @url = users_path
      @destroy_url = root_path
    end
  end

  # Paths

    # Installation paths
    def installation_path(installation)
      customer_installation_path(@customer, installation)
    end

    def installations_path(customer)
      customer_installations_path(@customer)
    end

    def new_installation_path
      new_customer_installation_path(@customer)
    end

    def edit_installation_path(installation)
      edit_customer_installation_path(@customer, installation)
    end

    # Beacon paths
    def beacon_path(beacon)
      customer_installation_beacon_path(@customer, @installation, beacon)
    end

    def new_beacon_path
      new_customer_installation_beacon_path(@customer, @installation)
    end

    def edit_beacon_path(beacon)
      edit_customer_installation_beacon_path(@customer, @installation, beacon)
    end

    # Audio clip paths
    def audio_clip_path(audio_clip)
      customer_installation_beacon_path(@customer, @installation, @beacon, audio_clip)
    end
end
