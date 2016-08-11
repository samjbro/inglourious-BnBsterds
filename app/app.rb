ENV['RACK_ENV'] ||= 'development'

require_relative 'datamapper_config'
require 'sinatra/base'
# require './app/user'

class InglouriousBnB < Sinatra::Base
  enable :sessions
  use Rack::MethodOverride

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
      redirect '/'
  end

  delete '/session/sign-out' do
    session[:id] = nil
    redirect '/'
  end

  post '/booking_request' do
    booking_request = BookingRequest.new(start_date: params[:start_date],
                                            end_date: params[:end_date])
    space = Space.get(params[:space_id])
    booking_request.user = current_user
    booking_request.space = space
    current_user.bookingRequests << booking_request
    space.bookingRequests << booking_request
    booking_request.save
    space.save
    current_user.save

    redirect '/spaces/confirmation'
  end

  get '/spaces/confirmation' do
    @booking_request = BookingRequest.first(user_id: current_user.id)
    @space = Space.get(@booking_request.space_id)
    erb :'spaces/confirmation'
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
