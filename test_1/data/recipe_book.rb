require "pg"
require_relative "ingredient"
require_relative "recipe"
require_relative "step"

class RecipeBook
  attr_accessor :recipes

  def initialize
    @recipe_book = PG.connect(dbname: "recipe_boss")
    @recipes = []
    load_recipes
  end

  def load_recipes
    recipe_sql = "SELECT * FROM recipes"
    recipes = @recipe_book.exec(recipe_sql)

    recipes.each do |recipe|
      ingredients_sql = "SELECT * FROM ingredients WHERE recipe_id = $1"
      ingredients = @recipe_book.exec_params(ingredients_sql, [recipe["id"]])
      ingredients = ingredients.map do |tuple|
        Ingredient.new(
          tuple["id"],
          tuple["name"],
          tuple["recipe_id"],
        )
      end
      
      steps_sql = "SELECT * FROM steps WHERE recipe_id = $1"
      steps = @recipe_book.exec_params(steps_sql, [recipe["id"]])
      steps = steps.map do |tuple|
        Step.new(
          tuple["id"],
          tuple["name"],
          tuple["recipe_id"],
        )
      end
      
      recipe =  Recipe.new(
        recipe["id"],
        recipe["name"],
        recipe["cook_time"],
        ingredients, 
        steps)

      @recipes << recipe
    end
  end

  def all
    @recipes
  end

  def find(id)
    @recipes.find { |recipe| recipe.id == id }
  end

  def each
    @recipes.each do |recipe|
      yield(recipe)
    end
  end

  def delete(recipe_id)
    sql = "DELETE FROM recipes WHERE id = $1"
    @recipe_book.exec_params(sql, [recipe_id])
  end
end