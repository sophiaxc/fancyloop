class StaticPagesController < ApplicationController
  def home
    @project = current_user.projects.build if signed_in?
    @projects = current_user.projects.paginate(page: params[:page]) if signed_in?
  end

  def about
  end
end
