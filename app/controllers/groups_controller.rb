class GroupsController < ApplicationController

  # Check URL below for Devise's helper methods for eg. authentication etc.
  # https://github.com/plataformatec/devise#controller-filters-and-helpers

  def index
    @groups = Group.all
  end

  def show
    @group = Group.find(params[:id])
  end

  def new

  end

  def edit

  end

  def create

  end

  def update

  end

  def destroy

  end

  private
  def group_params
    #params.require( ).permit( )
  end
end
