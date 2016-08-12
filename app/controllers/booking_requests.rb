class InglouriousBnB < Sinatra::Base

  post '/requests/index' do
    @booking_request = BookingRequest.get(params[:request_id])
    @booking_request.update(approved: true) if params[:approval] == 'Approve'
    @booking_request.update(approved: false) if params[:approval] == 'Reject'
    erb :'requests/confirmation'
  end

  post '/booking_request' do
    require_sign_in("You must be signed-in to book a space!")
    booking_request = BookingRequest.new(start_date: params[:start_date],
                                            end_date: params[:end_date])
    space = Space.get(params[:space_id])
    booking_request.user = current_user
    booking_request.space = space
    current_user.bookingRequests << booking_request
    space.bookingRequests << booking_request
    if booking_request.save(:first_submit)
      space.save
      current_user.save
      redirect '/spaces/confirmation'
    else
      flash.now[:errors] = ["The space is unavailable for the dates you have selected"]
      @space = space
      erb :'spaces/detail'
    end
  end

end
