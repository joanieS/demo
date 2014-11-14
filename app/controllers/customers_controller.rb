require 'securerandom'

class CustomersController < ApplicationController
  
  before_action :set_customer, only: [:show, :edit, :update, :destroy]
  
  # @active_installations = Installation.where(:customer_id => @customer.id, :active => true)  

  # def self.active_installations
  #   @active_installations
  # end

  def show
    @users = User.where(customer_id: current_user.customer_id)
    @hash = Gmaps4rails.build_markers(@customer) do |customer, marker|
      marker.lat customer.latitude
      marker.lng customer.longitude
    end
  end

  def new
    @customer = Customer.new
  end

  def index
    # Function should be, increment by 1 mile until 5 results are shown
    @customers = Customer.all
    @actives = Customer.joins(:installations).where(installations: { :active => true }).uniq
    respond_to do |format|
      format.json { render :index, status: :ok, location: @customer }
      format.html { render :index }
    end
  end

  def create
    @customer = Customer.new(customer_params)
    @customer.activation_code = SecureRandom.hex
    respond_to do |format|
      if @customer.save
        current_user.update(customer_id: @customer.id)
        format.html { redirect_to @customer, notice: 'Customer was successfully created.' }
        format.json { render :show, status: :created, location: @customer }
      else
        format.html { render :new }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit; end

  def update
    respond_to do |format|
      if @customer.update(customer_params)
        format.html { redirect_to @customer, notice: 'Customer was successfully updated.' }
        format.json { render :show, status: :ok, location: @customer }
      else
        format.html { render :edit }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @customer.destroy
    respond_to do |format|
      format.html { redirect_to customers_url, notice: 'Customer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    def set_customer
      @customer = Customer.find(params[:id])
    end

    def customer_params
      params.require(:customer).permit(:name, :category, :activation_code, :latitude, :longitude, :address)
    end



    # def self.active_installations(id)
    #   Installation.where(:customer_id => id, :active => true)
    # end

end
