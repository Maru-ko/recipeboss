require 'sinatra'
require 'sinatra/reloader' if development?
require 'tilt/erubis'
# require 'pry'

require_relative 'data/recipe_book'

configure do
  enable :sessions
  set :session_secret, 'chicken'
  set :erb, :escape_html => true
end

helpers do

end

before do
  @recipe_book = RecipeBook.new
end

def initialize_new_recipe
  session[:num_of_ingredients] ||= 3
  session[:num_of_steps] ||= 3
end
#addition july 5  \/


# Return the next id depending on the type of object
# for use in saving the recipe or ingredient
# def next_id(object_type)
#   case object_type
#   when :recipe
#     @recipe_book.recipes.map { |recipe| recipe.id }.max + 1
#   when :ingredient
#     max_id = next_id(:recipe) - 1
#     last_recipe = @recipe_book.recipes.select { |recipe| recipe.id == max_id }.first
#     last_recipe.ingredients.map { |ingredient| ingredient.id }.max + 1
#   when :step
#     max_id = next_id(:recipe) - 1
#     last_recipe = @recipe_book.recipes.select { |recipe| recipe.id == max_id }.first
#     last_recipe.steps.map { |step| step.id }.max + 1
#   end
# end

# Create an array of given object type
# for turning a list of steps or ingredients into an array for saving
def make_arr(object_type)
  object_type = object_type.to_s
  result = []
  ingredient_id = Ingredient.current_id + 1
  step_id = Step.current_id + 1

  case object_type
  when "ingredient"
    session[:num_of_ingredients].times do |num|
      current_object = params[(object_type + (num+1).to_s).to_sym]
      current_object = current_object.empty? ? "You didn't put anything here" : current_object
      ingredient = Ingredient.new(ingredient_id, current_object, Recipe.current_id + 1)
      ingredient_id += 1
      result << ingredient
    end
  when "step"
    session[:num_of_steps].times do |num|
      current_object = params[(object_type + (num+1).to_s).to_sym]
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

get "/recipes/new" do
  initialize_new_recipe
  erb :new_recipe, layout: :layout
end

get "/recipes/new/ingredients/add" do
  session[:num_of_ingredients] += 1
  redirect "/recipes/new"
end

get "/recipes/new/ingredients/delete" do
  session[:num_of_ingredients] -= 1
  redirect "/recipes/new"
end

get "/recipes/new/steps/add" do
  session[:num_of_steps] += 1
  redirect "/recipes/new"
end

get "/recipes/new/steps/delete" do
  session[:num_of_steps] -= 1
  redirect "/recipes/new"
end

def recipe_name_validation(name)
  name.empty? ? "NoNameRecipe" : name
end

post "/recipes/new" do
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
  session[:message] = "Your new recipe has been added."

  redirect "/"
end

#addition july 5 /\

def update_recipe(recipe)
  @recipe_book.delete_recipe(recipe.name)
  @recipe_book << recipe
  @recipe_book.save_recipes
end

get "/" do
  erb :index, layout: :layout
end

get "/recipes/:recipe_name" do
  @recipe = @recipe_book.find_recipe(params[:recipe_name])
  erb :view_recipe, layout: :layout
end
# dynamic
get "/recipes/:recipe_name/delete" do
  recipe_name = params[:recipe_name]
  @recipe_book.delete_recipe(recipe_name)
  @recipe_book.save_recipes
  redirect "/"
end
# dyname
get "/recipes/:recipe_name/edit" do
  @recipe = @recipe_book.find_recipe(params[:recipe_name])
  erb :edit
end
#
post "/recipes/:recipe_name/edit" do
  recipe = @recipe_book.find_recipe(params[:recipe_name])
  recipe.name = params[:name].strip
  recipe.cook_time = params[:time].strip
  recipe.ingredients.each do |ingredient|
    ingredient.name = params["ingredient_#{ingredient.id}"].strip
    ingredient.name = "You didn't put anything here" if ingredient.name.empty?
  end
  recipe.steps.each do |step|
    step.name = params["step_#{step.id}"].strip
    step.name = "You didn't put anything here" if step.name.empty?
  end

  update_recipe(recipe)
  redirect "/recipes/#{recipe.name}"
end
# dynamic
# Delete an ingredient when editing recipes
get "/recipes/:recipe_name/ingredients/:ingredient_id/delete" do
  recipe_name = params[:recipe_name]
  ingredient_id = params[:ingredient_id].to_i
  recipe = @recipe_book.find_recipe(recipe_name)
  recipe.delete_ingredient(ingredient_id)

  update_recipe(recipe)

  redirect "/recipes/#{recipe.name}/edit"
end

# Delete a step when editing recipes
get "/recipes/:recipe_name/steps/:step_id/delete" do
  recipe_name = params[:recipe_name]
  step_id = params[:step_id].to_i
  recipe = @recipe_book.find_recipe(recipe_name)
  recipe.delete_step(step_id)

  update_recipe(recipe)

  redirect "/recipes/#{recipe.name}/edit"
end

#dynami
# Add an ingredient when editing recipes
get "/recipes/:recipe_name/ingredients/add" do
  recipe_name = params[:recipe_name]
  recipe = @recipe_book.find_recipe(recipe_name)
  current_id = Ingredient.current_id
  recipe.ingredients << Ingredient.new(current_id + 1, "", recipe.id)

  update_recipe(recipe)

  redirect "/recipes/#{recipe.name}/edit"
end

# Add a step when editing recipes
get "/recipes/:recipe_name/steps/add" do
  recipe_name = params[:recipe_name]
  recipe = @recipe_book.find_recipe(recipe_name)
  current_id = Step.current_id
  recipe.steps << Step.new(current_id + 1, "", recipe.id)

  update_recipe(recipe)

  redirect "/recipes/#{recipe.name}/edit"
end
