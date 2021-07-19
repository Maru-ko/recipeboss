require 'nokogiri'
require 'open-uri'


require_relative 'recipe_book'
require_relative 'recipe'
require_relative 'ingredient'
require_relative 'step'
require 'yaml'


# Parsing for descriptions on plainoldrecipes

def parse_ingredients(html, recipe_id, ingredient_id = 1)
  ingredients = []
  next_id = ingredient_id

  html.search("ul.ingredients-list").each do |thing|
  thing.css("li").each do |ingredient|
      ingredient = Ingredient.new(next_id, ingredient.content, recipe_id)
      ingredients << ingredient
      next_id += 1
    end
  end
  ingredients
end

# Parsing for descriptions on plainoldrecipes

def parse_descriptions(html, recipe_id, step_id = 1)
  steps = []
  next_id = step_id

  html.search("ol").each do |thing|
    thing.css("li").each do |description|
      step = Step.new(next_id, description.content, recipe_id)
      steps << step
      next_id += 1
    end
  end
  steps
end

# Parsing for description on plainold recipes
def parse_recipe_name(html)
  name = ""
  html.search("h1").each do |thing|
    name << thing.content
  end
  name
end

def create_a_recipe(recipes, html)
  last_recipe = recipes.last
  next_recipe_id = last_recipe.nil? ? 1 : last_recipe.id + 1
  next_ingredient_id = last_recipe.nil? ? 1 : last_recipe.ingredients.last.id + 1
  next_step_id = last_recipe.nil? ? 1 : last_recipe.steps.last.id + 1
  name = parse_recipe_name(html)
  cook_time = [30, 45].sample
  ingredients = parse_ingredients(html, next_recipe_id, next_ingredient_id)
  steps = parse_descriptions(html, next_recipe_id, next_ingredient_id)
  filters =  ['Quick & Easy']
  Recipe.new(next_recipe_id, name, cook_time, ingredients, steps, filters)
end

# vegetarian_urls = [
#   "https://www.marthastewart.com/348566/john-legends-macaroni-and-cheese",
#   "https://www.marthastewart.com/1535235/vegetarian-shepherds-pie",
#   "https://www.marthastewart.com/1535618/split-pea-soup-spinach-and-barley",
#   "https://www.marthastewart.com/1532088/vegan-lentil-soup",
#   "https://www.marthastewart.com/1543073/brown-butter-sweet-potato-gnocchi-seeds",
#   "https://www.marthastewart.com/1554319/quick-carrots-and-snap-peas-lemony-mustard-dressing",
#   "https://www.marthastewart.com/1550854/spaghetti-tomato-saute"
# ]

# quick_easy_urls = [
#   "https://www.allrecipes.com/recipe/23998/a-good-easy-garlic-chicken/",
#   "https://www.marthastewart.com/329027/linguine-with-lemon-cream-sauce",
#   "https://www.marthastewart.com/312760/linguine-with-shrimp-and-white-wine",
#   "https://www.marthastewart.com/978784/one-pan-pasta",
#   "https://www.marthastewart.com/344987/salmon-with-brown-sugar-and-mustard-glaz",
#   "https://www.marthastewart.com/1050623/shaved-radish-fennel-and-parmesan-salad",
#   "https://www.marthastewart.com/1514636/eggs-goldenrod"
# ]

# breakfast_urls = [
#   "https://www.marthastewart.com/356069/breakfast-burrito",
#   "https://www.marthastewart.com/1050525/breakfast-vegetable-miso-soup-chickpeas",
#   "https://www.marthastewart.com/1050229/southwestern-breakfast-hash",
#   "https://www.marthastewart.com/1132757/savory-breakfast-bowl",
#   "https://www.marthastewart.com/314453/breakfast-quinoa",
#   "https://www.marthastewart.com/856108/breakfast-sausage-patties-fried-eggs",
#   "https://www.marthastewart.com/899329/egg-and-tomato-breakfast-sandwich-go",
#   "https://www.marthastewart.com/1539935/coconut-raspberry-breakfast-pudding",
#   "https://www.marthastewart.com/336520/ham-and-potato-bake",
#   "https://www.marthastewart.com/1050309/strawberry-rhubarb-crisp"
# ]

urls = [
  "https://www.allrecipes.com/recipe/23998/a-good-easy-garlic-chicken/",
  "https://www.marthastewart.com/329027/linguine-with-lemon-cream-sauce",
  "https://www.marthastewart.com/312760/linguine-with-shrimp-and-white-wine",
  "https://www.marthastewart.com/978784/one-pan-pasta",
  "https://www.marthastewart.com/344987/salmon-with-brown-sugar-and-mustard-glaz",
  "https://www.marthastewart.com/1050623/shaved-radish-fennel-and-parmesan-salad",
  "https://www.marthastewart.com/1514636/eggs-goldenrod"
]


url_experiment = "https://www.marthastewart.com/348566/john-legends-macaroni-and-cheese"
url1 = URI.open("https://plainoldrecipe.com/recipe?url=#{url_experiment}")
html = Nokogiri::HTML(url1)

recipe_book = RecipeBook.new
recipes = recipe_book.recipes

urls.each do |url|
  parsed_url = URI.open("https://plainoldrecipe.com/recipe?url=#{url}")
  html = Nokogiri::HTML(parsed_url)
  recipe = create_a_recipe(recipes, html)
  recipe_book.recipes << recipe
end

recipe_book.save_recipes


