class InglouriousBnB < Sinatra::Base
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
end
