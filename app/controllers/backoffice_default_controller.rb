class BackofficeDefaultController < ApplicationController

  before_action :authenticate_user!
  before_action :hide_footer



  private

  def hide_footer
    @hide_footer = true
  end

end



