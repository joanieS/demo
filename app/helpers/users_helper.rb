module UsersHelper
  include ApplicationHelper

  def full_name(user)
    "#{user.first_name} #{user.last_name}"
  end

  def edit_user_title
    current_user.customer_id ? "Edit User" : "Existing Company"
  end

  def update_successful(format)
  	format.html { redirect_to customer_path(current_user.customer_id), notice: "User was successfully updated." }
  	format.json { render :index, status: :ok, location: users_path }
  end
  
end
