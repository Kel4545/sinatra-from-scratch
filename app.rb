require "sinatra"
require "gschool_database_connection"
require "rack-flash"

class App < Sinatra::Application
  enable :sessions
  use Rack::Flash

  def initialize
    super
    @database_connection = GschoolDatabaseConnection::DatabaseConnection.establish(ENV["RACK_ENV"])
  end

  get "/" do
    erb :home
  end

post '/register' do
  username = params[:username]
  email = params[:email]
  @database_connection.sql("INSERT INTO users (username, email) values ('#{username}','#{email}')")
  flash[:notice] = "Thank you for registering"
  redirect '/'
end
 end
