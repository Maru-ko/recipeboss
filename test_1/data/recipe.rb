require_relative 'ingredient'
require_relative 'step'

class Recipe
  attr_reader :id
  attr_accessor :name, :cook_time, :ingredients, :steps

  def initialize(id, name, cook_time, ingredients = [], steps = [])
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

  def self.all
    all_recipes = []

    recipe_sql = "SELECT * FROM recipes"
    recipes = DB.query(recipe_sql)

    recipes.each do |recipe|
      ingredients_sql = "SELECT * FROM ingredients WHERE recipe_id = $1"
      ingredients = DB.query(ingredients_sql, recipe["id"])
      ingredients = ingredients.map do |tuple|
        Ingredient.tuple_to_ingredient_instance(tuple)
      end

      steps_sql = "SELECT * FROM steps WHERE recipe_id = $1"
      steps = DB.query(steps_sql, recipe["id"])
      steps = steps.map do |tuple|
        Step.tuple_to_step_instance(tuple)
      end

      recipe =  tuple_to_recipe_instance(recipe, ingredients, steps)

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
        Ingredient.tuple_to_ingredient_instance(tuple)
      end

      steps_sql = "SELECT * FROM steps WHERE recipe_id = $1"
      steps = DB.query(steps_sql, recipe["id"])
      steps = steps.map do |tuple|
        Step.tuple_to_step_instance(tuple)
      end

      new_recipe = tuple_to_recipe_instance(recipe, ingredients, steps)
    end
    new_recipe
  end

  def self.tuple_to_recipe_instance(tuple, ingredients, steps)
    Recipe.new(
      tuple["id"],
      tuple["name"],
      tuple["cook_time"],
      ingredients,
      steps)
  end

  def self.create(attributes)
    recipe = Recipe.new(
      attributes["id"],
      attributes["name"],
      attributes["cook_time"]
    )

    sql = "INSERT INTO recipes (name, cook_time) VALUES($1, $2) RETURNING id"
    result = DB.query(sql, recipe.name, recipe.cook_time)
    recipe.id = result.first["id"].to_i
    recipe
  end

  def destroy
  end

  def save
  end
end

