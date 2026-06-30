class Users::RegistrationsController < Devise::RegistrationsController
  layout 'heroica_auth', only: [:edit]

  def update
    self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)
    resource_updated = update_resource(resource, account_update_params)

    if resource_updated
      set_flash_message! :notice, :updated
      bypass_sign_in resource, scope: resource_name if sign_in_after_change_password?
      redirect_to after_update_path_for(resource)
    else
      clean_up_passwords resource
      set_minimum_password_length
      flash.now[:alert] = resource.errors.full_messages.to_sentence.presence
      render :edit, status: :unprocessable_entity, layout: 'heroica_auth'
    end
  end

  protected

  def after_update_path_for(_resource)
    root_path
  end
end
