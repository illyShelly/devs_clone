class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def home
    # top 3 devs with highest hourly rate -> model method
    @developers = Developer.top_devs
  end
end
