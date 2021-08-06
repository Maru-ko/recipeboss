require_relative 'ingredient'
require_relative 'step'

class Recipe
  attr_accessor :id, :name, :cook_time, :ingredients, :steps, :filters

  @@current_id = 0

  def initialize(id, name, cook_time, ingredients, steps)
    @id = id
    @name = name
    @cook_time = cook_time
    @ingredients = ingredients
    @steps = steps
  end

  def delete_ingredient(ingredient_id)
    @ingredients.reject! {|i| i.id == ingredient_id}
  end

  def delete_step(step_id)
    @steps.reject! {|i| i.id == step_id}
  end

  def self.current_id
    @@current_id
  end

  def Recipe.all
    all_recipes = []

    recipe_sql = "SELECT * FROM recipes"
    recipes = DB.query(recipe_sql)

    recipes.each do |recipe|
      ingredients_sql = "SELECT * FROM ingredients WHERE recipe_id = $1"
      ingredients = DB.query(ingredients_sql, recipe["id"])
      ingredients = ingredients.map do |tuple|
        Ingredient.new(
          tuple["id"],
          tuple["name"],
          tuple["recipe_id"],
        )
      end

      steps_sql = "SELECT * FROM steps WHERE recipe_id = $1"
      steps = DB.query(steps_sql, recipe["id"])
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

    all_recipes << recipe
    end
    all_recipes
  end

  def self.find(id)
    new_recipe = ''

    recipe_sql = "SELECT * FROM recipes WHERE id = $1"
    recipes = DB.query(recipe_sql, id)

    recipes.each do |recipe|
      ingredients_sql = "SELECT * FROM ingredients WHERE recipe_id = $1"
      ingredients = DB.query(ingredients_sql, recipe["id"])
      ingredients = ingredients.map do |tuple|
        Ingredient.new(
          tuple["id"],
          tuple["name"],
          tuple["recipe_id"],
        )
      end

      steps_sql = "SELECT * FROM steps WHERE recipe_id = $1"
      steps = DB.query(steps_sql, recipe["id"])
      steps = steps.map do |tuple|
        Step.new(
          tuple["id"],
          tuple["name"],
          tuple["recipe_id"],
        )
      end

      new_recipe = Recipe.new(
        recipe["id"],
        recipe["name"],
        recipe["cook_time"],
        ingredients,
        steps)

    end
    new_recipe
  end
end
