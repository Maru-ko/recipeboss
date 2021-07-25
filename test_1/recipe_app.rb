require 'dotenv/load'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'tilt/erubis'
require 'airrecord'
require 'pry'
require 'pry-byebug'

require_relative './data/recipe_book'

configure do
  enable :sessions
  set :session_secret, 'chicken'
  set :erb, :escape_html => true
end

helpers do
  def random_recipes(n)
    recipe_book = RecipeBook.all(view: "Recipes_Names_Only")
    recipe_book.shuffle.first(n)
  end
end

# before do
#   @recipe_book = RecipeBook.all
# end

def initialize_new_recipe
  session[:num_of_ingredients] ||= 3
  session[:num_of_steps] ||= 3
end

def make_arr(object_type)
  object_type = object_type.to_s
  result = []

  case object_type
  when 'ingredient'
    session[:num_of_ingredients].times do |num|
      new_ingredient_name = params["ingredient#{num + 1}"]
      next if new_ingredient_name.empty?
      ingredient = Ingredient.create("name" => new_ingredient_name)
      result << ingredient.id
    end
  when 'step'
    session[:num_of_steps].times do |num|
      new_step_name = params["step#{num + 1}"]
      next if new_step_name.empty?
      step = Step.create("name" => new_step_name)
      result << step.id
    end
  end

  result
end

def clear_recipe_log
  session.delete(:num_of_steps)
  session.delete(:num_of_ingredients)
end

# Main Page
get '/' do
  erb :index, layout: :layout
end

# Show all recipes
get '/all_recipes' do
  @recipe_book = RecipeBook.all(view: "Recipes_Names_Only", sort: {"name" => "asc"})
  erb :all_recipes, layout: :layout
end

# -----------------------------Create new recipe--------------------------------
get '/recipes/new' do
  initialize_new_recipe
  erb :new_recipe, layout: :layout
end

get '/recipes/new/ingredients/add' do
  session[:num_of_ingredients] += 1
  redirect '/recipes/new'
end

get '/recipes/new/ingredients/delete' do
  session[:num_of_ingredients] -= 1
  redirect '/recipes/new'
end

get '/recipes/new/steps/add' do
  session[:num_of_steps] += 1
  redirect '/recipes/new'
end

get '/recipes/new/steps/delete' do
  session[:num_of_steps] -= 1
  redirect '/recipes/new'
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
  ingredients = make_arr(:ingredient)
  steps = make_arr(:step)

  name = recipe_name_validation(params[:name])
  cook_time = cook_time_validation(params[:cook_time])

  new_recipe = RecipeBook.create(
    "name" => name,
    "cook time" => cook_time,
    "ingredients" => ingredients,
    "steps" => steps
  )

  clear_recipe_log

  session[:message] = 'Your new recipe has been added.'

  redirect '/all_recipes'
end

# -------------------------------------View Recipe----------------------------
get '/recipes/:recipe_id' do
  @recipe = RecipeBook.find(params[:recipe_id])
  erb :view_recipe, layout: :layout
end

# -------------------------------------View Recipe----------------------------
get '/recipes/:recipe_id/delete' do
  recipe = RecipeBook.find(params[:recipe_id])
  recipe.destroy
  redirect '/all_recipes'
end

# ----------------------------------------Edit Recipe---------------------------
get '/recipes/:recipe_id/edit' do
  @recipe = RecipeBook.find(params[:recipe_id])
  erb :edit
end

post '/recipes/:recipe_id/edit' do
  recipe = RecipeBook.find(params[:recipe_id])
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
  recipe = RecipeBook.find(params[:recipe_id])
  ingredient = Ingredient.new("name" => "new ingredient name", "recipes" => [recipe.id])
  ingredient.create
  redirect "/recipes/#{params[:recipe_id]}/edit"
end

# Add a step when editing recipes
get '/recipes/:recipe_id/steps/add' do
  recipe = RecipeBook.find(params[:recipe_id])
  step = Step.new("name" => "new step detail", "recipes" => [recipe.id])
  step.create
  redirect "/recipes/#{params[:recipe_id]}/edit"
end

# ----------------------------------------About-------------------------------

get '/about' do
  erb :about, layout: :layout
end

# ----------------------------------------Generate Weekly Menu------------------
get '/generate_weekly_menu' do
  @weekly_recipes = @recipe_book.weekly_menu_generate('vegetarian')
  erb :weekly_menu, layout: :layout
end

# res n dev

# get '/new_layout' do
#   erb :index, layout: :layout2
# end

# get '/tesuto' do
#   erb :tesuto, layout: :layout4
# end
