ENV['RACK_ENV'] ||= 'development'

require_relative 'datamapper_config'
require 'sinatra/base'

class InglouriousBnB < Sinatra::Base
  enable :sessions

  get '/' do
    @name = session[:name]
    erb :index
  end

  get '/users/new' do
    erb :'users/new'
  end

  post '/users/new' do
    session[:name] = params[:name]
    redirect('/')
  end

  get '/users/profile' do
    erb :'users/profile'
  end
  helpers do
    def current_user
      @current_user = User.get(session[:id])
    end
  end
end
