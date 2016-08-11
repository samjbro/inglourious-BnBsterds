class BookingRequest

  include DataMapper::Resource

  property :id, Serial
  property :start_date, Date
  property :end_date, Date
  property :approved, Boolean, default: false

  belongs_to :user
  belongs_to :space

  validates_with_method :start_date,
                        :end_date,
                        :space,
                        :method => :validates_booking_dates

  def validates_booking_dates
    space_range = (@space.start_date.to_date..@space.end_date.to_date)
    request_range = (@start_date.to_date..@end_date.to_date)
    true if ( request_range.begin >= space_range.begin && request_range.max <= space_range.max)
  end

end
