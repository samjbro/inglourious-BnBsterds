class BookingRequest

  include DataMapper::Resource

  property :id, Serial
  property :start_date, Date
  property :end_date, Date
  property :approved, Boolean, default: false

  belongs_to :user
  belongs_to :space

end
