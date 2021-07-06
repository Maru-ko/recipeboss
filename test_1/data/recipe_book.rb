require 'yaml'

require_relative 'recipe'
require_relative 'ingredient'
require_relative 'step'

class RecipeBook
  attr_accessor :recipes

  def initialize
    @recipes = []
    load_recipes
  end

  # Recipes is an array
  def load_recipes
    recipes = Psych.load_file('recipes.yml')
    recipes.each do |recipe|
      recipe =  Recipe.new(
        recipe[:id],
        recipe[:name],
        recipe[:cook_time],
        recipe[:ingredients].map do |ingredient|
          Ingredient.new(
            ingredient[:id],
            ingredient[:name],
            ingredient[:origin_recipe_id]
            )
        end,
        recipe[:steps].map do |step|
          Step.new(
            step[:id],
            step[:name],
            step[:origin_recipe_id]
            )
        end
      )
      @recipes << recipe
    end
  end

  def save_recipes
    formatted_recipes = []

    @recipes.each do |recipe|
      new_recipe = {}


      new_recipe[:id] = recipe.id
      new_recipe[:name] = recipe.name
      new_recipe[:cook_time] = recipe.cook_time

      new_recipe[:ingredients] = []

      recipe.ingredients.each do |ingredient|
        new_recipe[:ingredients] << {
          id: ingredient.id,
          name: ingredient.name,
          origin_recipe_id: ingredient.origin_recipe_id
        }
      end

      new_recipe[:steps] = []

      recipe.steps.each do |step|
        new_recipe[:steps] << {
          id: step.id,
          name: step.name,
          origin_recipe_id: step.origin_recipe_id
        }
      end

      formatted_recipes << new_recipe
    end

    File.open('./recipes.yml', 'w') do |file|
      file.write(Psych.dump(formatted_recipes))
    end
  end

  def each
    @recipes.each do |recipe|
      yield(recipe)
    end
    self
  end

  def last
    @recipes.last
  end

  def <<(recipe)
    raise TypeError, 'can only add Recipe objects' unless recipe.instance_of? Recipe
    @recipes << recipe
  end
  alias_method :add, :<<
end
