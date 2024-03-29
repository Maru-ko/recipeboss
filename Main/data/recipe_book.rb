# require "pg"
Airrecord.api_key = ENV['AIRTABLE_API_KEY']

class RecipeBook < Airrecord::Table
  self.base_key = ENV['AIRTABLE_BASE_ID']
  self.table_name = "recipes"

  has_many :ingredients, class: "Ingredient", column: "ingredients"
  has_many :steps, class: "Step", column: "steps"

  def name
    self["name"]
  end

  def name=(new_name)
    self["name"] = new_name
  end

  def cook_time
    self["cook time"]
  end

  def cook_time=(new_cook_time)
    self["cook time"] = new_cook_time
  end
end

class Ingredient < Airrecord::Table
  self.base_key = ENV['AIRTABLE_BASE_ID']
  self.table_name = 'ingredients'

  belongs_to :recipe_book, class: "RecipeBook", column: "recipes"

  def name
    self["name"]
  end

  def name=(new_name)
    self["name"] = new_name
  end
end

class Step < Airrecord::Table
  self.base_key = ENV['AIRTABLE_BASE_ID']
  self.table_name = "steps"

  belongs_to :recipe_book, class: "RecipeBook", column: "recipes"

  def name
    self["name"]
  end

  def name=(new_name)
    self["name"] = new_name
  end
end


# class RecipeBook
#   def initialize
#     @recipe_book = PG.connect(dbname: "recipe_boss")
#     @recipes = []
#     load_recipes
#   end

#   def load_recipes
#     recipe_sql = "SELECT * FROM recipes"
#     recipes = @recipe_book.exec(recipe_sql)

#     recipes.each do |recipe|
#       ingredients_sql = "SELECT * FROM ingredients WHERE recipe_id = $1"
#       ingredients = @recipe_book.exec_params(ingredients_sql, [recipe["id"]])
#       ingredients = ingredients.map do |tuple|
#         Ingredient.new(
#           tuple["id"],
#           tuple["name"],
#           tuple["recipe_id"],
#         )
#       end
      
#       steps_sql = "SELECT * FROM steps WHERE recipe_id = $1"
#       steps = @recipe_book.exec_params(steps_sql, [recipe["id"]])
#       steps = steps.map do |tuple|
#         Step.new(
#           tuple["id"],
#           tuple["name"],
#           tuple["recipe_id"],
#         )
#       end
      
#       recipe =  Recipe.new(
#         recipe["id"],
#         recipe["name"],
#         recipe["cook_time"],
#         ingredients,
#         steps)

#       @recipes << recipe
#     end
#   end

#   def all
#     @recipes
#   end

#   def find(id)
#     @recipes.find { |recipe| recipe.id == id }
#   end

#   def each
#     @recipes.each do |recipe|
#       yield(recipe)
#     end
#   end

#   def delete(recipe_id)
#     sql = "DELETE FROM recipes WHERE id = $1"
#     @recipe_book.exec_params(sql, [recipe_id])
#   end

#   def self.create(hsh)
#     sql = "INSERT INTO recipes(name, cook_time) VALUES($1, $2);"
#     @recipe_book.exec_params(sql, [hsh["name"], hsh["cook_time"])
#     sql2 = "SELECT id FROM recipes WHERE name = $1"
#     recipe_id = @recipe_book.exec_params(sql2, [hsh["name"]])[0][0]
#     hsh["ingredients"].each do |ingredient|
#       ingredietns_sql = "INSERT INTO ingredients(name, recipe_id) VALUES($1, $2);"
#     end
#   end
# end
