class HomeController < ApplicationController
  skip_before_action :authenticate_user!
  skip_before_action :validatesession

  def index
    if user_signed_in?
      redirect_to authenticated_root_path
    else
      redirect_to new_user_session_path
    end
  end
end
