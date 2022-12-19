require_relative 'ingredient'
require_relative 'step'

module Filters
  def self.set_recipe_filter(recipe_id, filter_name)
    search_sql = "SELECT id FROM filters WHERE name ~ $1;"
    filter_id = DB.query(search_sql, filter_name).values.first[0]
    update_sql = "INSERT INTO filters_recipes (filter_id, recipe_id) VALUES($1, $2);"
    DB.query(update_sql, filter_id, recipe_id)
  end

  def self.update_recipe_filter(recipe_id, filters)
    delete_sql = "DELETE FROM filters_recipes WHERE recipe_id = $1;"
    DB.query(delete_sql, recipe_id)
    if !filters.nil?
      filters.each do |filter_name|
        set_recipe_filter(recipe_id, filter_name)
      end
    end
  end

  def self.names
    search_sql = "SELECT name FROM filters;"
    DB.query(search_sql)
  end
end

class Recipe
  attr_accessor :name, :cook_time, :ingredients, :steps, :id, :filters

  WEEKDAY = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri']

  def initialize(id, name, cook_time, ingredients = [], steps = [], filters = [])
    @id = id
    @name = name
    @cook_time = cook_time
    @ingredients = ingredients
    @steps = steps
    @filters = filters
  end

  def self.menu_days
    WEEKDAY
  end

  def delete_ingredient(ingredient_id)
    @ingredients.reject! {|i| i.id == ingredient_id}
  end

  def delete_step(step_id)
    @steps.reject! {|i| i.id == step_id}
  end

  def self.all
    all_recipes = []

    recipe_sql = "SELECT * FROM recipes ORDER BY name"
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

      filters_sql = <<~FILTER
        SELECT name FROM filters
        JOIN filters_recipes ON filters_recipes.filter_id = filters.id
        WHERE recipe_id = $1;
      FILTER
      filters = DB.query(filters_sql, recipe["id"]).map {|tuple| tuple["name"]}           

      recipe =  tuple_to_recipe_instance(recipe, ingredients, steps, filters)

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
      
      filters_sql = <<~FILTER
        SELECT name FROM filters
        JOIN filters_recipes ON filters_recipes.filter_id = filters.id
        WHERE recipe_id = $1;
      FILTER
      filters = DB.query(filters_sql, recipe["id"]).map {|tuple| tuple["name"]}

      new_recipe = tuple_to_recipe_instance(recipe, ingredients, steps, filters)
    end
    new_recipe
  end

  def self.tuple_to_recipe_instance(tuple, ingredients, steps, filters)
    Recipe.new(
      tuple["id"].to_i,
      tuple["name"],
      tuple["cook_time"],
      ingredients,
      steps,
      filters)
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
    sql = "DELETE FROM recipes WHERE id = $1"
    DB.query(sql, @id)
  end

  def save
    sql = "UPDATE recipes SET name = $1, cook_time = $2 WHERE id = $3"
    DB.query(sql, @name, @cook_time, @id)
  end

  def self.meals_by_two_filters(filter1, filter2)
    sql = <<~FILTER
    SELECT recipes.name FROM recipes
    JOIN filters_recipes ON filters_recipes.recipe_id = recipes.id
    JOIN filters ON filters.id = filters_recipes.filter_id
    WHERE filters.name = $1 OR filters.name = $2
    GROUP BY recipes.name
    HAVING COUNT(recipes.name) = 2;
  FILTER

    DB.query(sql, filter1, filter2).values.map { |meal| meal[0] }.shuffle
  end

  def self.meals_by_one_filter(filter)
    sql = <<~FILTER
    SELECT recipes.name FROM recipes
    JOIN filters_recipes ON filters_recipes.recipe_id = recipes.id
    JOIN filters ON filters.id = filters_recipes.filter_id
    WHERE filters.name = $1
  FILTER

    DB.query(sql, filter).values.map { |meal| meal[0] }
  end

  def self.generate_day_plan(breakfast, non_breakfast)
    plan = {}
    WEEKDAY.length.times do |i|
      day = WEEKDAY[i]
      plan[day] = {}
      plan[day]['Breakfast'] = breakfast.pop || "You need more recipes"
      plan[day]['Lunch'] = non_breakfast.pop || "You need more recipes"
      plan[day]['Dinner'] = non_breakfast.pop || "You need more recipes"
    end
    plan
  end 

  def self.generate_vegetarian_plan
    breakfast = meals_by_two_filters('Vegetarian', 'Breakfast')
    non_breakfast = (meals_by_one_filter('Vegetarian') - breakfast).shuffle
    generate_day_plan(breakfast, non_breakfast)
  end

  def self.generate_quick_and_easy_plan
    breakfast = meals_by_two_filters('Quick and Easy', 'Breakfast')
    non_breakfast = (meals_by_one_filter('Quick and Easy') - breakfast).shuffle
    generate_day_plan(breakfast, non_breakfast)
  end

  def self.generate_normal_plan
    breakfast = meals_by_one_filter('Breakfast')
    non_breakfast = (Recipe.all.map { |recipe| recipe.name } - breakfast).shuffle
    generate_day_plan(breakfast, non_breakfast)
  end

end

