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
    recipes = Psych.load_file("./recipes.yaml")
    recipes.each do |recipe|
      recipe =  Recipe.new(
        recipe[:id],
        recipe[:name],
        recipe[:description],
        recipe[:cook_time],
        recipe[:ingredients].map do |ingredient|
          Ingredient.new(ingredient[:id], ingredient[:name])
        end,
        recipe[:steps].map do |step|
          Step.new(step[:id], step[:name])
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
      new_recipe[:description] = recipe.description
      new_recipe[:cook_time] = recipe.cook_time

      new_recipe[:ingredients] = []

      recipe.ingredients.each do |ingredient|
        new_recipe[:ingredients] << { id: ingredient.id, name: ingredient.name }
      end

      new_recipe[:steps] = []

      recipe.steps.each do |step|
        new_recipe[:steps] << { id: step.id, name: step.name }
      end

      formatted_recipes << new_recipe
    end

    File.open('./recipes.yaml', 'w') do |file|
      file.write(Psych.dump(formatted_recipes))
    end
  end
end
