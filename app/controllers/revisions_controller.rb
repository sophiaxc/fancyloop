class RevisionsController < ApplicationController
  before_filter :signed_in_user, only: [:create, :destroy]
  before_filter :correct_user,   only: [:create, :destroy]

  def show
    if not signed_in?
      store_location
      @user = User.new
    end
    @revision = Revision.find(params[:id])
    @feedback = @revision.feedbacks.build
  end

  def destroy
    @revision.destroy
    redirect_to @revision.project
  end

  def create
    @project = current_user.projects.find_by_id(params[:revision][:project_id])
    params[:revision].delete(:project_id)
    @revision = @project.revisions.build(params[:revision])
    if @revision.save
      redirect_to @project
    else
      redirect_to @project
    end
  end

  private
    def correct_user
      if params[:revision] and params[:revision][:project_id]
        @project = current_user.projects.find_by_id(params[:revision][:project_id])
        redirect_to root_path if @project.nil?
      else
        @revision = Revision.find_by_id(params[:id])
        redirect_to root_path if not current_user?(@revision.project.user)
      end
    end
end
