class UsersController < ApplicationController

  def groups
    @groups = current_user.group
    @title = 'My meetup groups'
    render 'groups/index'
  end
end