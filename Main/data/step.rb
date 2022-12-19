class Step
  attr_accessor :id, :name, :recipe_id

  def initialize(id, name, recipe_id)
    @id = id
    @name = name
    @recipe_id = recipe_id
  end

  def self.create(attributes)
    step = Step.new(
      attributes["id"],
      attributes["name"],
      attributes["recipe_id"]
    )


    sql = "INSERT INTO steps (name, recipe_id) VALUES ($1, $2) RETURNING id"
    result = DB.query(sql, step.name, step.recipe_id).first
    step.id = result["id"].to_i
    step
  end

  def self.tuple_to_step_instance(tuple)
    Step.new(
      tuple["id"],
      tuple["name"],
      tuple["recipe_id"])
  end

  def self.find(id)
    sql = "SELECT * FROM steps WHERE id = $1"
    result = DB.query(sql, id).first

    Step.tuple_to_step_instance(result)
  end

  def destroy
    sql = "DELETE FROM steps WHERE id = $1"
    DB.query(sql, @id)
  end

  def save
    sql = "UPDATE steps SET name = $1 WHERE id = $2"
    DB.query(sql, @name, @id)
  end
end
