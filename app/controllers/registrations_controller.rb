class RegistrationsController < Devise::RegistrationsController

  protected

  def after_update_path_for(_resource)
    admin_path(current_admin)
  end
end
