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
                        :method => :validates_booking_dates,
                        :when => [:first_submit]

  def validates_booking_dates
    space_dates = (@space.start_date.to_date..@space.end_date.to_date).to_a
    other_booking_requests = BookingRequest.all(space: @space, approved: true)
    other_booking_requests.each do |request|
      space_dates -= (request.start_date.to_date..request.end_date.to_date).to_a
    end
    request_dates = (@start_date.to_date..@end_date.to_date).to_a
    true if ((space_dates & request_dates) == request_dates)
  end

end
