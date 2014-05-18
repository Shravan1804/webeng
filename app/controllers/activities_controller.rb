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
    @group = Group.find(params[:group_id])
	  @activity = Activity.new
  end

  def create
    @activity = Activity.new(activity_params)

    if @activity.save
      @group = Group.find(@activity.group_id)
      redirect_to @group
    else
      @group = Group.find(params[:activity][:group_id])
      render action: 'new'
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

    oauth_confirm_url = "http://127.0.0.1:3000/tweet"

    @client = TwitterOAuth::Client.new(
      :consumer_key => '6k9kVE0xZHccPOK5IG8Ah9pgN',
      :consumer_secret => 'sXd7Fgogxet3D1UQYSdkoB5Ncj3I4B7Im31wNSU66JTCCU2ALK'
    )

    @request_token = @client.request_token(:oauth_callback => oauth_confirm_url)

    session[:token] = @request_token.token
    session[:secret] = @request_token.secret

    redirect_to @request_token.authorize_url

    #:oauth_callback required for web apps, since oauth gem by default force PIN-based flow
    #( see http://groups.google.com/group/twitter-development-talk/browse_thread/thread/472500cfe9e7cdb9/848f834227d3e64d )
    #request_token.authorize_url
    # => http://twitter.com/oauth/authorize?oauth_token=TOKEN

    # render json: request_token

    # activity = Activity.find(params[:id])
    # activity.definitive = true
    # activity.save
    # redirect_to :back
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
