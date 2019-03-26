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
      raise
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

# params
# @booking
# => #<Booking id: 9, start_date: "2019-03-30", end_date: "2019-04-01", user_id: 1, developer_id: 4, created_at: "2019-03-26 20:22:18", updated_at: "2019-03-26 20:22:18">
# >>  @developer
# => #<Developer id: 4, first_name: "TJ", last_name: " Holowaychuk", github_username: "tj", avatar_url: "https://avatars2.githubusercontent.com/u/25254?s=4...", bio: "Founder of Apex\r\nhttps://apex.sh, a non-startup.\r\n...", hourly_rate: 390, bookings_count: 2, user_id: 1, created_at: "2019-03-26 13:46:14", updated_at: "2019-03-26 13:46:14">
# >>  @developer.unavailable_dates
# => [{:from=>Wed, 27 Mar 2019, :to=>Thu, 28 Mar 2019}, {:from=>Sat, 30 Mar 2019, :to=>Mon, 01 Apr 2019}]
# >>

# rails console -> array as a result for particular dev

# first_order = Booking.where(developer_id: 10)

#   Booking Load (0.4ms)  SELECT "bookings".* FROM "bookings" WHERE "bookings"."developer_id" = $1  [["developer_id", 10]]
# => [#<Booking:0x00007fb59e1747c8
#   id: 3,
#   start_date: Wed, 27 Mar 2019,
#   end_date: Thu, 28 Mar 2019,
#   user_id: 1,
#   developer_id: 10,
#   created_at: Tue, 26 Mar 2019 18:48:23 UTC +00:00,
#   updated_at: Tue, 26 Mar 2019 18:48:23 UTC +00:00>]
# first_order[0].start_date...

#  array = test[0].unavailable_dates
#    (0.5ms)  SELECT "bookings"."start_date", "bookings"."end_date" FROM "bookings" WHERE "bookings"."developer_id" = $1  [["developer_id", 13]]
# => [
#   {:from=>Wed, 27 Mar 2019, :to=>Fri, 29 Mar 2019},
#   {:from=>Wed, 27 Mar 2019, :to=>Thu, 28 Mar 2019},
#   {:from=>Sat, 30 Mar 2019, :to=>Wed, 10 Apr 2019}
#   ]

#  date_string = array[0][:from] = Wed, 27 Mar 2019...
#  # date_string.class = Date
#  date_string.strftime('%F') = "2019-03-27"
#  # ... => store in array of disabled for particular developer
#  # and pushed in booking.js


