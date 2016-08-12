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

  helpers do
    def current_user
      @current_user = User.get(session[:id])
    end

    def check_availability(spaces, filter_range)
      spaces.reject do |space|
        space_range = (space.start_date.to_date..space.end_date.to_date)
        (space_range.max < filter_range.begin || filter_range.max < space_range.begin)
      end
    end

    def require_sign_in(reason)
      unless current_user
        flash.next[:errors] = [reason]
        redirect '/session/new'
      end
    end

  end

end
