ENV['RACK_ENV'] ||= 'development'

require_relative 'datamapper_config'
require 'sinatra/base'
require 'sinatra/flash'
require 'sinatra/partial'

require_relative 'server'
require_relative 'controllers/users'
require_relative 'controllers/spaces'
require_relative 'controllers/sessions'
require_relative 'controllers/booking_requests'
