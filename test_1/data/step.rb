class Step
  attr_accessor :id, :name, :recipe_id

  def initialize(id, name, recipe_id)
    @id = id
    @name = name
    @recipe_id = recipe_id
  end

  def self.create(attributes)
    name = attributes["name"]
    recipe_id = attributes["recipe_id"]

    sql = "INSERT INTO steps (name, recipe_id) VALUES ($1, $2)"
    DB.query(sql, name, recipe_id)
  end

  def self.tuple_to_step_instance(tuple)
    Step.new(
      tuple["id"],
      tuple["name"],
      tuple["recipe_id"])
  end

  def self.find(id)
  end

  def destroy
  end

  def save
end
