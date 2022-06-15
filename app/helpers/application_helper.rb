module ApplicationHelper

  def user_accessible?
    (current_user.admin? || current_user.founder?) if current_user
  end
end
