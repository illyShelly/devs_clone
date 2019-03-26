class AvailabilityValidator < ActiveModel::EachValidator

  def validate_each(record, attribute, value)
    bookings = Booking.where(["developer_id =?", record.developer_id])
    date_ranges = bookings.map { |b| b.start_date..b.end_date }

    date_ranges.each do |range|
      if range.include? value
        record.errors.add(attribute, "not available")
      end
    end
  end
end

# RUBLOBOZ - medium
# RECORD is the object being validated, ATTRIBUTE is either start_date or end_date and VALUE is whatever is currently assigned to start_date and end_date.
# We find all of the BOOKINGS for the record, and then build a LIST OF RANGES of unavailable dates (date_ranges is an Array of Arrays).
# If the value is included in ANY of these ranges, we add an error to the attribute with the indication that the said date is “not available”.
