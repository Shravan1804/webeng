class UsersController < ApplicationController

  def show
    user = User.find(params[:id])
    @groups = user.group
    @title = user.email + '\'s meetup groups'
    render 'groups/index'
  end
end