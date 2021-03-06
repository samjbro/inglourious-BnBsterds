require 'bcrypt'

class User
  include DataMapper::Resource

  attr_reader   :password
  attr_accessor :password_confirmation

  property :id, Serial
  property :name, String, required: true
  property :email, String, unique: true, required: true
  property :password_digest, String, length: 60
  has n, :spaces
  has n, :bookingRequests

  validates_confirmation_of :password

  def password=(password)
    @password = BCrypt::Password.create(password)
    self.password_digest = @password
  end

  def self.password_authentication(email, password)
    user = first(email: email)
    if user && BCrypt::Password.new(user.password_digest) == password
      return user
    end
    nil
  end

end
