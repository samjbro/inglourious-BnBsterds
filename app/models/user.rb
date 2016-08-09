require 'bcrypt'

class User
  include DataMapper::Resource

  attr_reader   :password
  attr_accessor :password_confirmation

  property :id, Serial
  property :name, String
  property :email, String
  property :password_digest, String, length: 60

  validates_confirmation_of :password

  def password=(password)
    @password = BCrypt::Password.create(password)
    self.password_digest = @password
  end

end
