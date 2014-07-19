require 'securerandom'

class CustomersController < ApplicationController
  
  before_action :set_customer, only: [:show, :edit, :update, :destroy]

  class Forbidden < StandardError; end

  def show; end

  def new
    @customer = Customer.new
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
    check_user_permission
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

    def check_user_permission
      raise "Forbidden" unless current_user.customer_id == @customer.id
    end

    def customer_params
      params.require(:customer).permit(:name, :category, :activation_code)
    end
end
