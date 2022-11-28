class SettingsController < ApplicationController
  before_action :authenticate_user!

  def edit
    @user = current_user
  end

  def update
    current_user.update(settings_params)
    redirect_to root_path, notice: 'Settings updated'
  end

  private

  def settings_params
    params.require(:user).permit(:project_name, :project_description, :bio)
  end
end
