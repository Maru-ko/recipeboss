# require "dotenv/load"
# require "pry"
# require "pry-byebug"
# require "airrecord"

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

  def ingredients
    self["ingredients"].map do |id|
      Ingredient.find(id)
    end
  end

  def steps
    self["steps"].map do |id|
      Step.find(id)
    end
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

# binding.pry
# recipes = RecipeBook.all


# recipe_book = RecipeBook.all
# p recipe_book
# p recipe_book.first

  # attr_accessor :recipes

  # WEEKDAYS = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday']

  # def initialize
  #   @recipes = []
  #   load_recipes
  # end

  # Recipes is an arrays
  # def load_recipes
  #   recipes = Psych.load_file('recipes.yml')
  #   recipes.each do |recipe|
  #     recipe =  Recipe.new(
  #       recipe[:id],
  #       recipe[:name],
  #       recipe[:cook_time],
  #       recipe[:ingredients].map do |ingredient|
  #         Ingredient.new(
  #           ingredient[:id],
  #           ingredient[:name],
  #           ingredient[:origin_recipe_id]
  #           )
  #       end,
  #       recipe[:steps].map do |step|
  #         Step.new(
  #           step[:id],
  #           step[:name],
  #           step[:origin_recipe_id]
  #           )
  #       end,
  #       recipe[:filters]
  #     )
  #     @recipes << recipe
  #   end
  # end

  # def save_recipes
  #   formatted_recipes = []

  #   @recipes.sort_by {|recipe| recipe.id}.each do |recipe|
  #     new_recipe = {}


  #     new_recipe[:id] = recipe.id
  #     new_recipe[:name] = recipe.name
  #     new_recipe[:cook_time] = recipe.cook_time

  #     new_recipe[:ingredients] = []

  #     recipe.ingredients.each do |ingredient|
  #       new_recipe[:ingredients] << {
  #         id: ingredient.id,
  #         name: ingredient.name,
  #         origin_recipe_id: ingredient.origin_recipe_id
  #       }
  #     end

  #     new_recipe[:steps] = []

  #     recipe.steps.each do |step|
  #       new_recipe[:steps] << {
  #         id: step.id,
  #         name: step.name,
  #         origin_recipe_id: step.origin_recipe_id
  #       }
  #     end

  #     new_recipe[:filters] = recipe.filters 

  #     formatted_recipes << new_recipe
  #   end

  #   File.open('./recipes.yml', 'w') do |file|
  #     file.write(Psych.dump(formatted_recipes))
  #   end
  # end

  # def each
  #   @recipes.each do |recipe|
  #     yield(recipe)
  #   end
  #   self
  # end

  # def last
  #   @recipes.last
  # end

#   def <<(recipe)
#     raise TypeError, 'can only add Recipe objects' unless recipe.instance_of? Recipe
#     @recipes << recipe
#   end
#   alias_method :add, :<<

#   def find_recipe(recipe_name)
#     @recipes.select {|recipe| recipe.name == recipe_name}.first
#   end

#   def delete_recipe(recipe_name)
#     @recipes.reject! { |recipe| recipe.name == recipe_name}
#   end

#   def weekly_menu_generate(filter)
#     other_recipes = @recipes.select{ |recipe| recipe.filters.include?(filter) && !recipe.filters.include?('breakfast') }.shuffle
#     breakfast_recipes = @recipes.select{ |recipe| recipe.filters.include?(filter) && recipe.filters.include?('breakfast') }.shuffle
#     weekly_recipes = {}
#     7.times do |num|
#       weekly_recipes[WEEKDAYS[num]] = [breakfast_recipes.delete_at(0)]
#       2.times do 
#         weekly_recipes[WEEKDAYS[num]] << other_recipes.delete_at(0)
#       end
#     end
#     weekly_recipes
#   end
# end
