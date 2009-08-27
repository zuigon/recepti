# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_Recepti_session',
  :secret      => '803bdd1f66bd53c129c7ada21d0f978616834e7e4526b6adb006482a8735a0a5847d7f53ad2704e1eca978c97692315036960a66c4c4165f1df1be1dae721c5e'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
