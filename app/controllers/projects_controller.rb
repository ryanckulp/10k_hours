class ProjectsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_project

  def update
    @project.update(project_params)
    redirect_to root_path, notice: 'Project updated'
  end

  private

  def set_project
    @project = Project.find_by(id: params[:id])
  end

  def project_params
    params.require(:project).permit(:name, :tagline, :description, :external_url)
  end
end
