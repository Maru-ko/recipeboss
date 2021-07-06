class Step
  attr_accessor :id, :name, :origin_recipe_id

  def initialize(id, name, origin_recipe_id)
    @id = id
    @name = name
    @origin_recipe_id = origin_recipe_id
  end
end
