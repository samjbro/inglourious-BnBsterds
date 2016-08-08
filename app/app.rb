ENV['RACK_ENV'] ||= 'development'

require_relative 'datamapper_config'
require 'sinatra/base'
# require './app/user'

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
    @user = User.create(name: params[:name], email: params[:email])
    session[:id] = @user.id
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
