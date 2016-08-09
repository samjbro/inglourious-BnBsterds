require 'bcrypt'

class User
  include DataMapper::Resource

  attr_reader   :password
  attr_accessor :password_confirmation

  property :id, Serial
  property :name, String, required: true
  property :email, String, unique: true, required: true
  property :password_digest, String, length: 60
  has n, :spaces, through: Resource

  validates_confirmation_of :password

  def password=(password)
    @password = BCrypt::Password.create(password)
    self.password_digest = @password
  end

end
