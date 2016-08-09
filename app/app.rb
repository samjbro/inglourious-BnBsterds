ENV['RACK_ENV'] ||= 'development'

require_relative 'datamapper_config'
require 'sinatra/base'

class InglouriousBnB < Sinatra::Base

  get '/' do
    erb :index
  end

  get '/spaces/new' do
    erb :'spaces/new'
  end

  post '/spaces' do
    space = Space.create(name: params[:space_name])
    # space.save
    redirect('/spaces/all')
  end

  get '/spaces/all' do
    @spaces = Space.all
    erb :'spaces/all'
  end
end
