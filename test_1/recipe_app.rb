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
  ingredient_id = Ingredient.current_id + 1
  step_id = Step.current_id + 1

  case object_type
  when 'ingredient'
    session[:num_of_ingredients].times do |num|
      current_object = params[(object_type + (num + 1).to_s).to_sym]
      current_object = current_object.empty? ? "You didn't put anything here" : current_object
      ingredient = Ingredient.new(ingredient_id, current_object, Recipe.current_id + 1)
      ingredient_id += 1
      result << ingredient
    end
  when 'step'
    session[:num_of_steps].times do |num|
      current_object = params[(object_type + (num + 1).to_s).to_sym]
      current_object = current_object.empty? ? "You didn't put anything here" : current_object
      step = Step.new(step_id, current_object, Recipe.current_id + 1)
      step_id += 1
      result << step
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

post '/recipes/new' do
  ingredients = make_arr(:ingredient)
  steps = make_arr(:step)

  name = recipe_name_validation(params[:name])

  new_recipe = Recipe.new(
    Recipe.current_id,
    name,
    params[:cook_time],
    ingredients,
    steps
  )

  # TODO: Any validation needed here?
  @recipe_book << new_recipe

  @recipe_book.save_recipes

  clear_recipe_log
  # binding.pry
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
