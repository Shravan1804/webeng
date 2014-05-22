class TwitterController < ApplicationController
  # skip_before_action :verify_authenticity_token

  def tweet

    client = TwitterOAuth::Client.new(
      :consumer_key => 'CIQ2fv3akOOp9l68NjQWNR6TS',
      :consumer_secret => 'kzVMmg1B92hMQWTAmx2iA89KZ9qKLgDwoaxhIRVBY8rxI7v8Rp'
    )

    access_token = client.authorize(
      session[:twitter_token],
      session[:twitter_secret],
      :oauth_verifier => params[:oauth_verifier]
    )

    activity = Activity.find(session[:activity_id])

    message = activity.name + ' is confirmed for ' + activity.start_date.strftime('%a %b %d') + ', from ' + activity.start_date.strftime('%H:%M') + ' to ' + activity.start_date.change(hour: activity.duration).strftime('%H:%M') + ' at ' + activity.location + '. Yeeehaaaw!'

    if client.authorized?
      client.update(message)
      redirect_to group_path(activity.group), notice: 'The following message was successfully tweeted: ' + message
    else
      redirect_to group_path(activity.group), notice: 'I tried to tweet but failed big time!'
    end
  end
end
