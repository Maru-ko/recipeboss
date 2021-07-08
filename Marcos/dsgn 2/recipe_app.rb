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

#addition july 5  \/

# Return the next id depending on the type of object
# for use in saving the recipe or ingredient
def next_id(object_type)
  case object_type
  when :recipe
    @recipe_book.recipes.map { |recipe| recipe.id }.max + 1
  when :ingredient
    max_id = next_id(:recipe) - 1
    last_recipe = @recipe_book.recipes.select { |recipe| recipe.id == max_id }.first
    last_recipe.ingredients.map { |ingredient| ingredient.id }.max + 1
  when :step
    max_id = next_id(:recipe) - 1
    last_recipe = @recipe_book.recipes.select { |recipe| recipe.id == max_id }.first
    last_recipe.steps.map { |step| step.id }.max + 1
  end
end

# Create an array of given object type
# for turning a list of steps or ingredients into an array for saving
def make_arr(object_type)
  object_type = object_type.to_s
  result = []
  num = 1
  ingredient_id = next_id(:ingredient)
  step_id = next_id(:step)

  while true
    current_object = params[(object_type + num.to_s).to_sym]
    break unless current_object

    case object_type
    when "ingredient"
      ingredient = Ingredient.new(ingredient_id, current_object)
      result << ingredient
    when "step"
      step = Step.new(step_id, current_object)
      result << step
    end

    num += 1
    ingredient_id += 1
    step_id += 1
  end

  result
end

# View the main app index
# get "/" do
#   @recipe_book = session[:recipe_book]
#   erb :index, layout: :layout
# end

# View the form to add a new recipe
get "/recipes/new" do
  # @recipe_book
  erb :new_recipe, layout: :layout
end

# View an individual recipe page (only for testing)
# get "/recipes/:recipe_id" do
#   @recipe_book = session[:recipe_book]
#   @recipe_id = params[:recipe_id].to_i
#   @recipe = @recipe_book.recipes.select { |recipe| recipe.id == @recipe_id }.first
#   erb :view_recipe
# endkz
post "/recipes" do
  @recipe_book = session[:recipe_book]
  ingredients = make_arr(:ingredient)
  steps = make_arr(:step)

  new_recipe = Recipe.new(
    next_id(:recipe),
    params[:name],
    params[:cook_time],
    ingredients,
    steps
  )

  # TODO: Any validation needed here?
  @recipe_book.recipes << new_recipe
  session[:message] = "Your new recipe has been added."

  redirect "/"
end

#addition july 5 /\

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
# dynamic
get "/recipes/:recipe_name/delete" do
  recipe_name = params[:recipe_name]
  session[:recipe_book].recipes.reject! { |recipe| recipe.name == recipe_name}
  redirect "/"
end
# dyname
get "/recipes/:recipe_name/edit" do
  @recipe = session[:recipe_book].recipes.select {|recipe| recipe.name == params[:recipe_name]}.first
  erb :edit
end
#
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
# dynamic
get "/recipes/:recipe_name/ingredients/:ingredient_id/delete" do
  recipe_name = params[:recipe_name]
  ingredient_id = params[:ingredient_id].to_i
  recipe = session[:recipe_book].recipes.select {|recipe| recipe.name == recipe_name}.first
  recipe.ingredients.reject! {|i| i.id == ingredient_id}

  update_recipe(recipe)

  redirect "/recipes/#{recipe.name}/edit"
end
#dynami
get "/recipes/:recipe_name/ingredients/add" do
  recipe_name = params[:recipe_name]
  recipe = session[:recipe_book].recipes.select {|recipe| recipe.name == recipe_name}.first
  current_id = recipe.ingredients.map {|i| i.id}.max
  current_id ||= 1
  recipe.ingredients << Ingredient.new(current_id + 1, "")

  redirect "/recipes/#{recipe.name}/edit"
end
