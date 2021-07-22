Airrecord.api_key = ENV['AIRTABLE_API_KEY']

class Step < Airrecord.table
  self.base_key = ENV['AIRTABLE_BASE_ID']
  self.table_name = "steps"

  belongs_to :recipe_book, class: "RecipeBook", column: "recipes"
end


#   attr_accessor :id, :name, :origin_recipe_id

#   @@current_id = 0

#   def initialize(id, name, origin_recipe_id)
#     @id = id
#     @name = name
#     @origin_recipe_id = origin_recipe_id
#     @@current_id += 1
#   end

#   def self.current_id
#     @@current_id += 1
#   end
# end
