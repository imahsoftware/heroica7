class Users::RegistrationsController < Devise::RegistrationsController
  layout 'heroica_auth', only: [:edit]

  protected

  def after_update_path_for(_resource)
    root_path
  end
end
