class UsersController < ApplicationController

  before_action :authenticate_user!

  before_action :set_user, only: [:show, :edit, :update, :destroy]

  before_action :set_customer

  def index
    @user = current_user
    @users = User.where(customer_id: current_user.customer_id)
  end

  def new
    @user = User.new
  end

  def edit; end

  def create
    @user = User.new(user_params)
    respond_to do |format|
      if @user.save
        format.html { redirect_to users_path, notice: 'User was successfully created.' }
        format.json { json_success_redirect }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    validate_user_permission
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to users_path, notice: 'User was successfully updated.' }
        format.json { json_success_redirect }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    validate_user_permission
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

    def validate_user_permission
      raise SecurityTransgression unless current_user == @user  
    end

    def json_success_redirect
      render :index, status: :ok, location: users_path
    end

    def user_params
      params.require(:user).permit(:first_name, :last_name, :username, :email)
    end
end
