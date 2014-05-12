class GroupsController < ApplicationController

  # Check URL below for Devise's helper methods for eg. authentication etc.
  # https://github.com/plataformatec/devise#controller-filters-and-helpers
  
  before_filter :require_owner, only: [:destroy, :edit, :update, :add_user, :store_user, :remove_user]
  
  helper_method :current_user_is_owner

  def index
    @groups = Group.all
  end

  def show
    @group = Group.find(params[:id])
  end

  def destroy
	@group = Group.find(params[:id])
	@group.destroy 
	redirect_to groups_path
  end

  def new
	@group = Group.new
  end

  def create
	@group = Group.new(group_params)
	@group.owner_id = current_user.id
	if @group.save
		redirect_to @group
	else
		render 'new'
	end
  end

  def edit
	@group = Group.find(params[:id])
  end

  def update
	@group = Group.find(params[:id])
	if @group.update(group_params)
		redirect_to @group
	else
		render 'edit'
	end
  end
  
  def add_user
	@group = Group.find(params[:id])
  end
  
  def store_user
	if member=User.find_by_email(add_user_params[:email])
		@group.user << member unless @group.user.include?(member)
		redirect_to @group
	else
		@group.errors.add(:email, " provided is not a valid user.")
		render 'add_user'
	end
  end
  
  def remove_user
	member=User.find(params[:user_param])
	@group.user.destroy(member)
	redirect_to @group
  end
  
  def current_user_is_owner
	return @group.owner_id==current_user.id
  end

  private
  def group_params
	params.require(:group).permit(:name, :hometown)
  end
  
  def add_user_params
	params.require(:user).permit(:email)
  end
  
  def require_owner
	@group = Group.find(params[:id])
	if current_user.id != @group.owner_id
		redirect_to @group
	end
  end
end
