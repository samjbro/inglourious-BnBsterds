class InglouriousBnB < Sinatra::Base
  get '/spaces/new' do
    erb :'spaces/new'
  end

  post '/spaces' do
    require_sign_in("You must be signed-in to create a space!")
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
    if session[:filter_to] == (nil || "") || session[:filter_from] == (nil || "")
      @spaces = Space.all
      flash.next["Please select a start and end date"]
    else
      filter_range = (Date.parse(session[:filter_from])..Date.parse(session[:filter_to]))
      @spaces = check_availability(Space.all, filter_range)
      session[:filter_to] = nil
      session[:filter_from] = nil
    end
    erb :'spaces/all'
  end


  post '/spaces/detail' do
    @space = Space.get(params[:space_id])
    erb :'spaces/detail'
  end

  post '/spaces/filtered' do
    if session[:filter_to] == (nil || "") || session[:filter_from] == (nil || "")
      flash.next["Please select a start and end date"]
      redirect '/spaces/all'
    else
      session[:filter_to] = params[:available_to]
      session[:filter_from] = params[:available_from]
      redirect '/spaces/all'
    end
  end

  get '/spaces/confirmation' do
    @booking_request = BookingRequest.first(user_id: current_user.id)
    @space = Space.get(@booking_request.space_id)
    erb :'spaces/confirmation'
  end
end
