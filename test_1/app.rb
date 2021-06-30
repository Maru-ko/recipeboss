require 'sinatra'
require 'sinatra/reloader' if development?
require 'tilt/erubis'

require_relative 'recipe_book'

configure do
  enable :sessions
  set :session_secret, 'chicken'

  set :erb, :escape_html => true
end

before do
  @recipe_book = RecipeBook.new
end

helpers do
 # this is for views
end





get "/" do
  #{}"<html><body><h1>Welcome to Recipe World</h1></body></html>"
  erb :index, layout: :layout
end

# View the form to add a new recipe
get "/recipes/new" do
  erb :new_recipe, layout: :layout
end