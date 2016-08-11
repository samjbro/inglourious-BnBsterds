ENV['RACK_ENV'] ||= 'development'

require_relative 'datamapper_config'
require 'sinatra/base'
require 'sinatra/flash'
require 'sinatra/partial'


class InglouriousBnB < Sinatra::Base
  enable :sessions
  use Rack::MethodOverride
  register Sinatra::Flash
  register Sinatra::Partial
  set :partial_template_engine, :erb
  enable :partial_underscores

  get '/' do
    @name = session[:name]
    erb :index
  end

  get '/users/new' do
    erb :'users/new'
  end

  post '/users/new' do
    @user = User.new(name: params[:name],
                        email: params[:email],
                        password: params[:password],
                        password_confirmation: params[:password_confirmation])
    if @user.save
      session[:id] = @user.id
      redirect('/')
    else
      flash.now[:errors] = @user.errors.full_messages
      erb :'users/new'
    end
  end

  get '/users/profile' do
    @spaces = Space.all(user_id: session[:id])
    erb :'users/profile'
  end


  get '/spaces/new' do
    erb :'spaces/new'
  end

  post '/spaces' do
     space = Space.new(name: params[:space_name],
                                    description: params[:space_description],
                                    price: params[:space_price].to_i,
                                    start_date: params[:space_start_date],
                                    end_date: params[:space_end_date])
     space.user = current_user
     current_user.spaces << space

     space.save
     current_user.save
    redirect('/spaces/all')
  end

  get '/spaces/all' do
    if session[:filter_to] == nil && session[:filter_from] == nil
      @spaces = Space.all
    else
      filter_range = (Date.parse(session[:filter_from])..Date.parse(session[:filter_to]))
      @spaces = check_availability(Space.all, filter_range)
    end
    erb :'spaces/all'
  end


  post '/spaces/detail' do
    @space = Space.get(params[:space_id])
    erb :'spaces/detail'
  end

  post '/spaces/filtered' do
    session[:filter_to] = params[:available_to]
    session[:filter_from] = params[:available_from]
    redirect '/spaces/all'
  end

  get '/session/new' do
    erb :'session/new'
  end

  post '/session/new' do
    user = User.password_authentication(params[:email], params[:password])
      if user
        session[:id] = user.id
        redirect '/'
      end
      flash.next[:errors] = ["Sign-in Failed, plese try again"]
      redirect '/session/new'
  end

  delete '/session/sign-out' do
    session[:id] = nil
    redirect '/'
  end

  helpers do
    def current_user
      @current_user = User.get(session[:id])
    end

    def check_availability(spaces, filter_range)
      return_arr = []
      spaces.each do |space|
        space_range = (space.start_date.to_date..space.end_date.to_date)
        unless (space_range.max < filter_range.begin || filter_range.max < space_range.begin)
          return_arr.push(space)
        end
      end
      return_arr
    end
  end
end
