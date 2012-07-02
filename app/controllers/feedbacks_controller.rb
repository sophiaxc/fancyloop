class FeedbacksController < ApplicationController
  before_filter :signed_in_user, only: [:destroy, :create]
  before_filter :correct_user,   only: [:destroy]

  def destroy
    @feedback.destroy
    redirect_to @feedback.revision
  end

  def create
    @revision = Revision.find_by_id(params[:feedback][:revision_id])
    params[:feedback].delete(:revision_id)
    @feedback = @revision.feedbacks.build(params[:feedback])
    if current_user
      @feedback.author = current_user.name
      @feedback.user_id = current_user.id
    end
    @feedback.save
    redirect_to @revision
  end
end
