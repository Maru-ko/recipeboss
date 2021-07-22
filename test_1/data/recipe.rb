require_relative 'ingredient'
require_relative 'step'

class Recipe
  attr_accessor :id, :name, :cook_time, :ingredients, :steps, :filters

  @@current_id = 0

  def initialize(id, name, cook_time, ingredients, steps, filters = [])
    @id = id
    @name = name
    @cook_time = cook_time
    @ingredients = ingredients
    @steps = steps
    @filters = filters
    @@current_id += 1
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
end
