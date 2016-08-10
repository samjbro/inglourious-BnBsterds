require 'data_mapper'
require 'dm-postgres-adapter'
require_relative 'models/user'
require_relative 'models/space.rb'
require_relative 'models/booking_request.rb'

DataMapper.setup(:default, ENV['DATABASE_URL'] || "postgres://localhost/inglouriousbnb_#{ENV['RACK_ENV']}")
DataMapper.finalize
DataMapper.auto_upgrade!
