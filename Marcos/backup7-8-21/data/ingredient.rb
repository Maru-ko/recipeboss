class Ingredient
  attr_accessor :id, :name, :origin_recipe_id

  @@ingredient_count = 0

  def initialize(id, name, origin_recipe_id)
    @id = id
    @name = name
    @origin_recipe_id = origin_recipe_id
    @@ingredient_count += 1
  end

  def self.current_id
    @@ingredient_count
  end
end
