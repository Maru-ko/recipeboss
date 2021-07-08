class Step
  attr_accessor :id, :name, :origin_recipe_id

  @@current_id = 0

  def initialize(id, name, origin_recipe_id)
    @id = id
    @name = name
    @origin_recipe_id = origin_recipe_id
    @@current_id += 1
  end

  def self.current_id
    @@current_id += 1
  end
end
