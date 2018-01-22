# A controller for static pages
class StaticController < ApplicationController
  skip_before_action :authenticate_user!

  def home
  end

end
