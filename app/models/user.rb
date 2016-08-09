
class User
  include DataMapper::Resource

  property :id, Serial, required: true
  property :name, String
  property :email, String
  has n, :spaces, through: Resource
  # property :password_digest, String, length: 60

end
