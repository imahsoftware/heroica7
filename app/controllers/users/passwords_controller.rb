class Users::PasswordsController < Devise::PasswordsController
  layout 'heroica_auth'

  protected

  def after_resetting_password_path_for(resource)
    resource.update_columns(sign_in_count: 2) if resource.sign_in_count.to_i <= 1
    session.delete(:must_change_password)
    menus_path
  end
end
