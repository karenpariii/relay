class PagesController < ApplicationController
  def home
  end

  def dashboard
    @bookings = current_user.takings
  end
end
