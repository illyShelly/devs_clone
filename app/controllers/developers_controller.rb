class DevelopersController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :set_developer, only: [:show]

  def index
    @skills = Skill.pluck(:name).sort
    @query = params[:query]
    if @query.present?
      # search by different tables and columns (first_name, github_username, skills)
      sql_query = "\
      developers.first_name @@ :query \
      OR developers.last_name @@ :query \
      OR developers.github_username @@ :query \
      OR skills.name @@ :query \
      "
      # @developers = Developer.where("first_name iLike ?", "%#{@query}%")
      @developers = Developer.where(sql_query, query: "%#{@query}").joins(:skills)
    else
      @developers = Developer.all
    end
    # @developers = Developer.includes(:skills)
  end

  def show
    # booking form on dev page
    @booking = Booking.new
  end

 def bookmarked
    @developers = current_user.bookmarked_developers
  end

  private

  def set_developer
    @developer = Developer.find(params[:id])
  end
end
