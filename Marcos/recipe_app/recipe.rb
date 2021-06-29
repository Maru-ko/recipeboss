require 'sinatra'
require 'sinatra/reloader' if development?
require 'tilt/erubis'

configure do
  enable :sessions
  set :session_secret, 'chicken'

  set :erb, :escape_html => true
end

before do

end

helpers do
 # this is for views
end





get "/" do
  #{}"<html><body><h1>Welcome to Recipe World</h1></body></html>"
  erb :index, layout: :layout
end