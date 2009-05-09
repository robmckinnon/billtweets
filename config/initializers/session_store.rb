# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_billtweets_session',
  :secret      => 'dfda414ab6572dbd1a6f220dc57f1fcef1e98c717a38e3a6cb1cabd05cc80d4ed0d35b6f52a3b22cd1dca29ec3abc068cf0e1c73b4fc4043cbc16721267fe43e'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
