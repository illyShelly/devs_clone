class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def home
    @developers = Developer.top_devs
  end
end
