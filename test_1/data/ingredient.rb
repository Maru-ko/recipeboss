Airrecord.api_key = ENV['AIRTABLE_API_KEY']

class Ingredient < Airrecord::Table
  self.base_key = ENV['AIRTABLE_BASE_ID']
  self.table_name = 'ingredients'

  belongs_to :recipe_book, class: "RecipeBook", column: "recipes"
end

  # attr_accessor :id, :name, :origin_recipe_id

  # @@ingredient_count = 0

#   def initialize(id, name, origin_recipe_id)
#     @id = id
#     @name = name
#     @origin_recipe_id = origin_recipe_id
#     @@ingredient_count += 1
#   end

#   def self.current_id
#     @@ingredient_count
#   end
# end
