class ApplicationController < ActionController::Base

  if Rails.env.staging?
    http_basic_authenticate_with name: Rails.application.credentials.basic_auth[:login], password: Rails.application.credentials.basic_auth[:password]

  end

end
