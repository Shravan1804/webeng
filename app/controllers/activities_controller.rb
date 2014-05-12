class ActivitiesController < ApplicationController

  # Check URL below for Devise's helper methods for eg. authentication etc.
  # https://github.com/plataformatec/devise#controller-filters-and-helpers

  helper_method :current_user_is_group_owner
  helper_method :get_group_name
  
  def index
	@activities = Activity.all
  end

  def show
	@activity = Activity.find(params[:id])
  end

  def destroy
	@activity = Activity.find(params[:id])
	group=Group.find(@activity.group_id)
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
		render 'new'
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
	group=Group.find(@activity.group_id)
	group.owner_id==current_user.id
  end
  
  def get_group_name
	group=Group.find(@activity.group_id)
	group.name
  end

  private
  def activity_params
    params.require(:activity).permit(:name, :location, :start_date, :description, :image, :group_id, :duration)
  end
end
