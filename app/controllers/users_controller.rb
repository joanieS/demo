class UsersController < ApplicationController

  before_action :authenticate_user!

  before_action :set_user, only: [:show, :edit, :update, :destroy]

  before_action :set_customer, only: [:index, :new, :create, :destroy]

  def index
    @user = current_user
    @users = User.where(customer_id: current_user.customer_id)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    respond_to do |format|
      if @user.save
        format.html { redirect_to users_path, notice: 'User was successfully created.' }
        format.json { render :index, status: :ok, location: users_path }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit; end

  def update
    # Normal user account update.
    if @user.customer_id
      respond_to do |format|
        if @user.update(user_params)
          format.html { redirect_to users_path, notice: "User was successfully updated." }
          format.json { render :index, status: :ok, location: users_path }
        else
          format.html { render :edit }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    else # Link user account with activation_code.
      set_customer_with_activation_code
      respond_to do |format|
        if link_customer_account
          format.html { redirect_to root_path, notice: "User account was successfully linked to company account." }
          format.json { render :index, status: :ok, location: users_path }
        else
          format.html { render :edit }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to root_path, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    def set_user
      @user = User.find(params[:id])
    end
  
    def set_customer
      @customer = Customer.find(current_user.customer_id)
    end

    def set_customer_with_activation_code
      @customer = Customer.where(activation_code: params[:activation_code]).take
    end

    def link_customer_account
      @user.update(customer_id: @customer.id)
    end

    def user_params
      params.require(:user).permit(:first_name, :last_name, :username, :email, :password, :password_confirmation, :customer_id)
    end
end
