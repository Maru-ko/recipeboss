require_relative 'ingredient'
require_relative 'step'

class Recipe
  attr_accessor :id, :name, :description, :cook_time, :ingredients, :steps

  def initialize(id, name, description, cook_time, ingredients, steps)
    @id = id
    @name = name
    @description = description
    @cook_time = cook_time
    @ingredients = ingredients
    @steps = steps
  end
end
