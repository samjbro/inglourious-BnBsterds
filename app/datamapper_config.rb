require 'data_mapper'
require 'dm-postgres-adapter'
require './app/models/user'

DataMapper.setup(:default, ENV['DATABASE_URL'] || "postgres://localhost/inglouriousbnb_#{ENV['RACK_ENV']}")
DataMapper.finalize
DataMapper.auto_upgrade!
