class Space
  include DataMapper::Resource

  property :id, Serial
  property :name, String
  property :description, Text

end
