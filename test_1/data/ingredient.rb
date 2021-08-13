class Ingredient
  attr_accessor :name, :id, :recipe_id

  def initialize(id, name, recipe_id)
    @id = id
    @name = name
    @recipe_id = recipe_id
  end

  def self.create(attributes)
    ingredient = Ingredient.new(
      attributes["id"],
      attributes["name"],
      attributes["recipe_id"]
    )


    sql = "INSERT INTO ingredients (name, recipe_id) VALUES ($1, $2) RETURNING id"
    result = DB.query(sql, ingredient.name, ingredient.recipe_id).first
    ingredient.id = result["id"].to_i
    ingredient
  end

  def self.tuple_to_ingredient_instance(tuple)
    Ingredient.new(
      tuple["id"],
      tuple["name"],
      tuple["recipe_id"])
  end

  def self.find(id)
    sql = "SELECT * FROM ingredients WHERE id = $1"
    result = DB.query(sql, id).first

    Ingredient.tuple_to_ingredient_instance(result)
  end

  def destroy
    sql = "DELETE FROM ingredients WHERE id = $1"
    DB.query(sql, @id)
  end

  def save
    sql = "UPDATE ingredients SET name = $1 WHERE id = $2"
    DB.query(sql, @name, @id)
  end
end

