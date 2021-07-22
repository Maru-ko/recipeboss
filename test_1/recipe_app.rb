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
    @recipe_book.shuffle.first(n)
  end
end

before do
  @recipe_book = RecipeBook.all
end

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

get '/' do
  erb :index, layout: :layout
end

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

def update_recipe(recipe)
  @recipe_book.delete_recipe(recipe.name)
  @recipe_book << recipe
  @recipe_book.save_recipes
end

get '/recipes/:recipe_id' do
  @recipe = RecipeBook.find(params[:recipe_id])
  erb :view_recipe, layout: :layout
end

# dynamic
get '/recipes/:recipe_name/delete' do
  recipe_name = params[:recipe_name]
  @recipe_book.delete_recipe(recipe_name)
  @recipe_book.save_recipes
  redirect '/all_recipes'
end

# dyname
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

# dynamic
# Delete an ingredient when editing recipes
get '/recipes/:recipe_name/ingredients/:ingredient_id/delete' do
  recipe_name = params[:recipe_name]
  ingredient_id = params[:ingredient_id].to_i
  recipe = @recipe_book.find_recipe(recipe_name)
  recipe.delete_ingredient(ingredient_id)

  update_recipe(recipe)

  redirect "/recipes/#{recipe.name}/edit"
end

# Delete a step when editing recipes
get '/recipes/:recipe_name/steps/:step_id/delete' do
  recipe_name = params[:recipe_name]
  step_id = params[:step_id].to_i
  recipe = @recipe_book.find_recipe(recipe_name)
  recipe.delete_step(step_id)

  update_recipe(recipe)

  redirect "/recipes/#{recipe.name}/edit"
end

# dynamic
# Add an ingredient when editing recipes
get '/recipes/:recipe_name/ingredients/add' do
  recipe_name = params[:recipe_name]
  recipe = @recipe_book.find_recipe(recipe_name)
  current_id = Ingredient.current_id
  recipe.ingredients << Ingredient.new(current_id + 1, '', recipe.id)

  update_recipe(recipe)

  redirect "/recipes/#{recipe.name}/edit"
end

# Add a step when editing recipes
get '/recipes/:recipe_name/steps/add' do
  recipe_name = params[:recipe_name]
  recipe = @recipe_book.find_recipe(recipe_name)
  current_id = Step.current_id
  recipe.steps << Step.new(current_id + 1, '', recipe.id)

  update_recipe(recipe)

  redirect "/recipes/#{recipe.name}/edit"
end

# fluffery

get '/all_recipes' do
  erb :all_recipes, layout: :layout
end

get '/about' do
  erb :about, layout: :layout
end

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
