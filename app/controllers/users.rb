class InglouriousBnB < Sinatra::Base

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
    end
    flash.now[:errors] = @user.errors.full_messages
    erb :'users/new'
  end

  get '/users/profile' do
    @spaces = Space.all(user_id: session[:id])
    @requests = BookingRequest.all(:space => @spaces)
    @request_details = []
    @requests.each do |request|
      @request_details.push({:space_name => Space.get(request.space_id).name ,
                             :customer_name => User.get(request.user_id).name,
                             :start_date => request.start_date,
                             :end_date => request.end_date,
                             :request_id => request.id})
    end

    erb :'users/profile'
  end

end
