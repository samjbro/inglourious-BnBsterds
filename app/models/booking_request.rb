class BookingRequest

  include DataMapper::Resource

  property :id, Serial
  property :start_date, Date
  property :end_date, Date

  belongs_to :user
  belongs_to :space

end
