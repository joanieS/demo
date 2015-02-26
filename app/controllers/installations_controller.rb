class InstallationsController < ApplicationController
  include InstallationsHelper

  before_filter :authenticate_user!, except: [:show]

  before_action :set_customer

  before_action :set_installation, only: [:show, :edit, :update, :destroy]

  def index
    set_installations
  end

  def show
    set_image_url
    if request.format.json?
      select_show(@installation)
      # binding.pry
      # select_audio_file()
      render action: "show"
    else
      authenticate_user!
      render action: "show"
    end
  end

  def new
    @installation = Installation.new
  end

  # def create
  #   @installation = Installation.new(installation_params)
  #   set_customer_id
  #   respond_to_create(@installation, "installation")
  # end

  def create
    @installation = Installation.new(installation_params)
    set_customer_id
    set_image_url
    respond_to do |format|
      if @installation.save
        format.html { redirect_to installation_path(@installation), notice: "Installation was successfully created." }
        format.json { render :show, status: :created, location: installation_path(@installation) }
      else
        format.html { render :new }
        format.json { render json: @installation.errors, status: :unprocessable_entity }     
      end
    end
  end
  
  def edit; end

  def update
    respond_to_update(@installation, "installation")
  end

  def destroy
    @installation.destroy
    respond_to_destroy(@installation, "installation")
  end

end
