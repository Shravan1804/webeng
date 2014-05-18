class TwitterController < ApplicationController

  def tweet
    client = TwitterOAuth::Client.new(
        :consumer_key => '6k9kVE0xZHccPOK5IG8Ah9pgN',
        :consumer_secret => 'sXd7Fgogxet3D1UQYSdkoB5Ncj3I4B7Im31wNSU66JTCCU2ALK'
    )

    access_token = client.authorize(
        session[:token],
        session[:secret],
        :oauth_verifier => params[:oauth_verifier]
    )

    if client.authorized?
      client.update('Testing!') # sends a twitter status update
    end

    render json: access_token

  end
end
