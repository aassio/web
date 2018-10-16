require 'authy'
Authy.api_key = Rails.application.credentials.twilio[:api_key]
Authy.api_uri = 'https://api.authy.com'