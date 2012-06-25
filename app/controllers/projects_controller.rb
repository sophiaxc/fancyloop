class ProjectsController < ApplicationController
  before_filter :signed_in_user, only: [:create, :destroy]
  before_filter :correct_user,   only: :destroy

  def destroy
    @project.destroy
    redirect_to root_path
  end

  def show
    @project = Project.find(params[:id])
    @revisions = @project.revisions
    @revision = @project.revisions.build if current_user?(@project.user)
  end

  def create
    @project = current_user.projects.build(params[:project])
    if @project.save
      flash[:success] = "Project created!"
      redirect_to @project
    else
      @projects = current_user.projects.paginate(page: params[:page])
      render 'static_pages/home'
    end
  end

  private
    def correct_user
      @project = current_user.projects.find_by_id(params[:id])
      redirect_to root_path if @project.nil?
    end
end
