class Space
  include DataMapper::Resource

  property :id, Serial
  property :name, String
  property :description, Text
  property :price, Integer
  property :start_date, String
  property :end_date, String

  belongs_to :user

end
