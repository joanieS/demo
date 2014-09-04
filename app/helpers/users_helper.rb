module UsersHelper

  def full_name(user)
    "#{user.first_name} #{user.last_name}"
  end

  def edit_user_title
    current_user.customer_id ? "Edit User" : "Existing Company"
  end
  
end
