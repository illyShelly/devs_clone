class DevelopersController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :set_developer, only: [:show]

  def index
    @developers = Developer.all
    # @developer = Developer.includes(:skills)
  end

  def show
    # booking form on dev page
    @booking = Booking.new
  end

  private

  def set_developer
    @developer = Developer.find(params[:id])
  end
end
