#Audio recording, record your voice, get it to lufthouse somehow

class InstallationsController < ApplicationController

  before_filter :authenticate_user!

  #before_action :set_customer, except: [:new, :create]

  before_action :set_installation, only: [:show, :edit, :update, :destroy]

  def index
    @installations = Installation.where(customer_id: @customer.id)
  end

  def show; end

  def new
    @installation = Installation.new
  end

  def create
    @installation = Installation.new(installation_params)
    set_customer_id
    respond_to do |format|
      if @installation.save
        format.html { redirect_to installation_path, notice: "Installation was successfully created." }
        format.json { render :show, status: :created, location: @installation }
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
      format.html { redirect_to installations_path, notice: "Installation was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

    def set_installation
        @installation = Installation.find(params[:id])
    end

    def set_customer
      @customer = Customer.find(current_user.customer_id)
    end

    def set_customer_id
      @installation.customer_id = current_user.customer_id
    end

    def installations_path
      customer_installations_path(@customer)
    end

    def installation_path
      customer_installation_path(@customer, @installation)
    end

    def installation_params
      params.require(:installation).permit(:name)
    end
end
