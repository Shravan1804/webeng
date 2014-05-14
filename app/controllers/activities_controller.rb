class ActivitiesController < ApplicationController

  # Check URL below for Devise's helper methods for eg. authentication etc.
  # https://github.com/plataformatec/devise#controller-filters-and-helpers

  helper_method :current_user_is_group_owner
  helper_method :get_group_name

  before_filter :require_owner, only: [:destroy, :mark_as_definitive]

  def index
	  @activities = Activity.all
  end

  def show
	  @activity = Activity.find(params[:id])
  end

  def destroy
    @activity = Activity.find(params[:id])
    group = Group.find(@activity.group_id)
    @activity.destroy
    redirect_to group
  end

  def new
	  @activity = Activity.new
  end

  def create
    @activity = Activity.new(activity_params)

    if @activity.save
      redirect_to Group.find(@activity.group_id)
    else
      redirect_to :back
    end
  end

  def edit
	  @activity = Activity.find(params[:id])
  end

  def update
    @activity = Activity.find(params[:id])
    if @activity.update(activity_params)
      redirect_to @activity
    else
      render 'edit'
    end
  end
  
  def current_user_is_group_owner
    group = Group.find(@activity.group_id)
    group.owner_id == current_user.id
  end
  
  def get_group_name
    group = Group.find(@activity.group_id)
    group.name
  end

  def vote
    activity = Activity.find(params[:id])
    unless activity.voters.include?(current_user) then
      activity.voters << current_user
    end
    redirect_to :back
  end

  def definitive
    activity = Activity.find(params[:id])
    activity.definitive = true
    activity.save
    redirect_to :back
  end

  private

  def require_owner
    @group = Activity.find(params[:id]).group
    if current_user.id != @group.owner_id
      flash[:error] = "You do not have permission to perform this action"
      redirect_to @group
    end
  end

  def activity_params
    params.require(:activity).permit(:name, :location, :start_date, :description, :image, :group_id, :duration)
  end
end
