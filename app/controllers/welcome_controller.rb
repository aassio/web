class WelcomeController < ApplicationController
  def index
    @email_subscription = EmailSubscription.new
  end
end
