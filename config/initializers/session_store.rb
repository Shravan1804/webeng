# Be sure to restart your server when you modify this file.

#Rails.application.config.session_store :cookie_store, key: '_webeng_meetup_groups_session', domain: "localhost:3000"
Rails.application.config.session_store :cache_store #, key: '_webeng_meetup_groups_session', domain: "localhost:3000"
