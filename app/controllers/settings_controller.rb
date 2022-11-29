class SettingsController < ApplicationController
  before_action :authenticate_user!

  def edit
    @project = Project.current
  end
end
