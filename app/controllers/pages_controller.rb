class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def home
    @developers = Developer.all.take(3)
  end
end
