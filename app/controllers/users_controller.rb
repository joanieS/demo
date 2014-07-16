class UsersController < ApplicationController
  # authenticate user with devise
  before_action :authenticate_user!
  before_action :set_customer

  # only index users for the current customer
  def index
    @users = User.where(customer_id: current_user.customer_id)
  end

  def show
  end

  def new
    @user = User.new
  end

  def edit
    @user = current_user
  end

  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  
    def set_customer
      @customer = Customer.find(current_user.customer_id)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:show, :new, :create, :edit, :update, :destroy)
    end
end
