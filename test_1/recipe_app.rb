require 'sinatra'
require 'sinatra/reloader' if development?
require 'tilt/erubis'

require_relative 'data/recipe_book'

configure do
  enable :sessions
  set :session_secret, 'chicken'
  set :erb, :escape_html => true
end

helpers do

end

before do
  session[:recipe_book] ||= RecipeBook.new
end

get "/" do
  erb :index, layout: :layout
end

get "/recipes/:recipe_name" do
  @recipe = session[:recipe_book].recipes.select {|recipe| recipe.name == params[:recipe_name]}.first
  erb :view_recipe, layout: :layout
end

get "/recipes/:recipe_name/delete" do
  recipe_name = params[:recipe_name]
  session[:recipe_book].recipes.reject! { |recipe| recipe.name == recipe_name}
  redirect "/"
end

get "/recipes/:recipe_name/edit" do
  @recipe = session[:recipe_book].recipes.select {|recipe| recipe.name == params[:recipe_name]}.first
  erb :edit
end

post "/recipes/:recipe_name/edit" do
  recipe = session[:recipe_book].recipes.select {|recipe| recipe.name == params[:recipe_name]}.first
  recipe.name = params[:name].strip
  recipe.cook_time = params[:time].strip
  recipe.ingredients.each do |ingredient|
    ingredient.name = params["ingredient_#{ingredient.id}"].strip
  end
  recipe.steps.each do |step|
    step.name = params["step_#{step.id}"].strip
  end

  session[:recipe_book].recipes.reject! { |r| r.name == recipe.name}
  session[:recipe_book].recipes << recipe
  redirect "/"
end
