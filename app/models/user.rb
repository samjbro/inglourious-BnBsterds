
class User
  include DataMapper::Resource

  property :id, Serial
  property :name, String
  property :email, String
  # property :password_digest, String, length: 60

end
