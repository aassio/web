class EmailSubscriptionsController < ApplicationController

  def create
    @email_subscription = EmailSubscription.new params[:email_subscription].permit(:email, :name)
    if params[:agree] == '1' && @email_subscription.save
      render 'create'
    else
      render 'new'
    end
  end


end
