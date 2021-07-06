require_relative 'ingredient'
require_relative 'step'

class Recipe
  attr_accessor :id, :name, :cook_time, :ingredients, :steps

  def initialize(id, name, cook_time, ingredients, steps)
    @id = id
    @name = name
    @cook_time = cook_time
    @ingredients = ingredients
    @steps = steps
  end
end
