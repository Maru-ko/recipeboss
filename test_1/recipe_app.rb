# ENV["RACK_ENV"] = "development"

require 'dotenv/load'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'tilt/erubis'
require 'pry'
require 'pry-byebug'
require 'nokogiri'
require 'open-uri'

require_relative './data/database_persistance'

# Note: Where does logger come from???
# Can I insert logger into database without using before...
# Ruby throws a warning because this is re-assigning a value to a constant each time a page reloads.

before do
  DB = DatabasePersistance.new(logger)
  @recipe_book = Recipe.all
end

# This makes the DB constant available in all the relavant classes that need to query the database.

require_relative './data/recipe'
require_relative './data/ingredient'
require_relative './data/step'

configure do
  enable :sessions
  set :session_secret, 'chicken'
  set :erb, :escape_html => true
end

configure(:development) do
  require "sinatra/reloader"
  also_reload "data/recipe_book.rb"
  also_reload "data/recipe.rb"
  also_reload "data/ingredient.rb"
  also_reload "data/step.rb"
end

helpers do
  def random_recipes(n)
    Recipe.all.shuffle.first(n)
  end
end

after do
  DB.disconnect
end

def initialize_new_recipe
  session[:num_of_ingredients] ||= 3
  session[:num_of_steps] ||= 3
end

def create_ingredients(recipe_id)
    session[:num_of_ingredients].times do |num|
      new_ingredient_name = params["ingredient#{num + 1}"]
      next if new_ingredient_name.empty?
      ingredient = Ingredient.create(
        "name" => new_ingredient_name,
        "recipe_id" => recipe_id)
  end
end

def create_steps(recipe_id)
  session[:num_of_steps].times do |num|
    new_step_name = params["step#{num + 1}"]
    next if new_step_name.empty?
    step = Step.create("name" => new_step_name, "recipe_id" => recipe_id)
  end
end

def create_filters(recipe_id)
  unless params[:filters].nil?
    params[:filters].each do |filter|
      Filters.set_recipe_filter(recipe_id, filter)
    end
  end
end

def clear_recipe_log
  session.delete(:num_of_steps)
  session.delete(:num_of_ingredients)
end

def get_ingredients_from_link(html)
  ingredients = []
  
  html.search("ul.ingredients-list").each do |thing|
    thing.css("li").each do |ingredient|
      ingredients << ingredient.content
    end
  end
  ingredients
end

def get_recipe_name_from_link(html)
  name = ""
  html.search("h1").each do |thing|
    name << thing.content
  end
  name
end

def get_steps_from_link(html)
  steps = []

  html.search("ol").each do |thing|
    thing.css("li").each do |description|
      steps << description.content
    end
  end
  steps
end

# Main Page
get '/' do
  erb :index, layout: :layout
end

# Show all recipes
get '/all_recipes' do
  erb :all_recipes, layout: :layout
end

# -----------------------------Create new recipe--------------------------------
get '/recipes/new' do
  erb :new_recipe, layout: :layout
end

get '/recipes/new/manual' do
  initialize_new_recipe
  @filters = Filters.names
  erb :new_recipe_manual, layout: :layout
end

get '/recipes/new/links/inputs' do
  link = params[:recipe_link]
  begin
    url = URI.open("https://plainoldrecipe.com/recipe?url=#{link}")
  rescue
    session[:message] = 'The link was invalid'
    redirect '/recipes/new/links'
  else
    html = Nokogiri::HTML(url)
    @recipe_name = get_recipe_name_from_link(html)
    @ingredients = get_ingredients_from_link(html)
    @steps = get_steps_from_link(html)
    @filters = Filters.names

    session[:num_of_ingredients] ||= @ingredients.length
    session[:num_of_steps] ||= @steps.length
    
    erb :new_recipe_links_inputs, layout: :layout
  end
end

get '/recipes/new/links' do
  erb :new_recipe_links, layout: :layout
end

get '/recipes/new/ingredients/add' do
  session[:num_of_ingredients] += 1
  redirect '/recipes/new/manual'
end

get '/recipes/new/ingredients/delete' do
  session[:num_of_ingredients] -= 1
  redirect '/recipes/new/manual'
end

get '/recipes/new/steps/add' do
  session[:num_of_steps] += 1
  redirect '/recipes/new/manual'
end

get '/recipes/new/steps/delete' do
  session[:num_of_steps] -= 1
  redirect '/recipes/new/manual'
end

def recipe_name_validation(name)
  name.empty? ? 'NoNameRecipe' : name
end

def cook_time_validation(cook_time)
  if cook_time.class == String && !cook_time.empty?
    cook_time
  else
    "Invalid time entered"
  end
end

post '/recipes/new' do
  name = recipe_name_validation(params[:name])
  cook_time = cook_time_validation(params[:cook_time])

  recipe = Recipe.create(
    "name" => name,
    "cook_time" => cook_time,
  )

  create_ingredients(recipe.id)
  create_steps(recipe.id)
  create_filters(recipe.id)

  clear_recipe_log

  session[:message] = "Your new recipe #{recipe.name} has been added."

  redirect '/all_recipes'
  # erb :test
end

# -------------------------------------View Recipe----------------------------
get '/recipes/:recipe_id' do
  @recipe = Recipe.find(params[:recipe_id])
  erb :view_recipe, layout: :layout
end

# -------------------------------------View Recipe----------------------------
get '/recipes/:recipe_id/delete' do
  Recipe.find(params[:recipe_id]).destroy
  redirect '/all_recipes'
end

# ----------------------------------------Edit Recipe---------------------------
get '/recipes/:recipe_id/edit' do
  @recipe = Recipe.find(params[:recipe_id])
  @filters = Filters.names
  erb :edit
end

post '/recipes/:recipe_id/edit' do
  recipe = Recipe.find(params[:recipe_id])
  recipe.name = params[:name].strip
  recipe.cook_time = params[:time].strip
  recipe.ingredients.each do |ingredient|
    ingredient.name = params[ingredient.id].strip
    ingredient.name = "You didn't put anything here" if ingredient.name.empty?
    ingredient.save
  end
  recipe.steps.each do |step|
    step.name = params[step.id].strip
    step.name = "You didn't put anything here" if step.name.empty?
    step.save
  end

  Filters.update_recipe_filter(recipe.id, params[:filters])

  recipe.save
  redirect "/recipes/#{recipe.id}"
end

# Delete an ingredient when editing recipes
get '/recipes/:recipe_id/ingredients/:ingredient_id/delete' do
  recipe_id = params[:recipe_id]
  Ingredient.find(params[:ingredient_id]).destroy
  redirect "/recipes/#{recipe_id}/edit"
end

# Delete a step when editing recipes
get '/recipes/:recipe_id/steps/:step_id/delete' do
  recipe_id = params[:recipe_id]
  Step.find(params[:step_id]).destroy
  redirect "/recipes/#{recipe_id}/edit"
end

# Add an ingredient when editing recipes
get '/recipes/:recipe_id/ingredients/add' do
  recipe = Recipe.find(params[:recipe_id])
  ingredient = Ingredient.create("name" => "new ingredient name", "recipe_id" => recipe.id)
  redirect "/recipes/#{params[:recipe_id]}/edit"
end

# Add a step when editing recipes
get '/recipes/:recipe_id/steps/add' do
  recipe = Recipe.find(params[:recipe_id])
  step = Step.create("name" => "new step detail", "recipe_id" => recipe.id)
  redirect "/recipes/#{params[:recipe_id]}/edit"
end

# ----------------------------------------About-------------------------------

get '/about' do
  erb :about, layout: :layout
end

# ----------------------------------------Generate Weekly Menu------------------
def generate_weekly_by_filter(filter)
  @meal = case filter
  when 'Vegetarian' then Recipe.generate_vegetarian_plan
  when 'Quick and Easy' then Recipe.generate_quick_and_easy_plan
  else Recipe.generate_normal_plan
  end 
end

get '/weekly_options' do
  erb :weekly_options, layout: :layout
end

get '/generate_weekly_menu' do
  @selection = params[:selection]
  @menu = generate_weekly_by_filter(@selection)
  @days = Recipe.menu_days
  erb :weekly_menu, layout: :layout
end

# res n dev

# get '/new_layout' do
#   erb :index, layout: :layout2
# end

# get '/tesuto' do
#   erb :tesuto, layout: :layout4
# end
