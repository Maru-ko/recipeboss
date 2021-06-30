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

def update_recipe(recipe)
  session[:recipe_book].recipes.reject! { |r| r.name == recipe.name}
  session[:recipe_book].recipes << recipe
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

  update_recipe(recipe)
  redirect "/recipes/#{recipe.name}"
end

get "/recipes/:recipe_name/ingredients/:ingredient_id/delete" do
  recipe_name = params[:recipe_name]
  ingredient_id = params[:ingredient_id].to_i
  recipe = session[:recipe_book].recipes.select {|recipe| recipe.name == recipe_name}.first
  recipe.ingredients.reject! {|i| i.id == ingredient_id}

  update_recipe(recipe)

  redirect "/recipes/#{recipe.name}/edit"
end

get "/recipes/:recipe_name/ingredients/add" do
  recipe_name = params[:recipe_name]
  recipe = session[:recipe_book].recipes.select {|recipe| recipe.name == recipe_name}.first
  current_id = recipe.ingredients.map {|i| i.id}.max
  current_id ||= 1
  recipe.ingredients << Ingredient.new(current_id + 1, "")

  redirect "/recipes/#{recipe.name}/edit"
end
