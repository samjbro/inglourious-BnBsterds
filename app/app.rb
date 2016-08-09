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
    @user = User.create(name: params[:name],
                        email: params[:email],
                        password: params[:password],
                        password_confirmation: params[:password_confirmation])
    session[:id] = @user.id
    redirect('/')
  end

  get '/users/profile' do
    erb :'users/profile'
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

  helpers do
    def current_user
      @current_user = User.get(session[:id])
    end
  end
end
