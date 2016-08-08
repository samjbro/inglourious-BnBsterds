ENV['RACK_ENV'] ||= 'development'

require_relative 'datamapper_config'
require 'sinatra/base'

class InglouriousBnB < Sinatra::Base

  get '/' do
    erb :index
  end
end
