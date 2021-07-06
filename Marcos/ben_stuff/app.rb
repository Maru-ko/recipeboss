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
  session[:recipe_book] ||= RecipeBook.new
end

helpers do
 # this is for views
end

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
get "/" do
  @recipe_book = session[:recipe_book]
  erb :index, layout: :layout
end

# View the form to add a new recipe
get "/recipes/new" do
  erb :new_recipe, layout: :layout
end

# View an individual recipe page (only for testing)
# get "/recipes/:recipe_id" do
#   @recipe_book = session[:recipe_book]
#   @recipe_id = params[:recipe_id].to_i
#   @recipe = @recipe_book.recipes.select { |recipe| recipe.id == @recipe_id }.first
#   erb :view_recipe
# end

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