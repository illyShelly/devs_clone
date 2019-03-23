class BookingsController < ApplicationController
  def create
    # who to book - dev
    @developer = Developer.find(params[:developer_id])
    @booking = Booking.new(booking_params)
    @booking.developer = @developer
    # who booked - user (helper)
    @booking.user = current_user
    if @booking.save
      redirect_to developers_path
    else
      # booking form on show page
      render 'developers/show'
    end
  end

  private

  def booking_params
    params.require(:booking).permit(:start_date, :end_date)
  end
end
