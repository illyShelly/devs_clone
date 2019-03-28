class Booking < ApplicationRecord
  belongs_to :developer, counter_cache: true
  belongs_to :user

  validates :start_date, :end_date, presence: true, availability: true
  validate :end_date_after_start_date

  def booked_date_range
    { from: :start_date, to: :end_date }
  end

  private

  def end_date_after_start_date
    return if end_date.blank? || start_date.blank?

    if end_date < start_date
      errors.add(:end_date, "must be after the start date")
    end
  end

  # already booked? -> check if (start_date..end_date).to_a not included? in bookings?


end

# github: robloboz
# The private method end_date_after_start_date VALIDATES that the end_date is not before the start_date. If it is, we add an ERROR to the ActiveRecord object.
# The other CUSTOM VALIDATOR (notice that the option being passed in line 5 of the above snippet availability: true is not a native rails validator) uses a different technique. We can write custom validators which inherit from ActiveModel::EachValidator
