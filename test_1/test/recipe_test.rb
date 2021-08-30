require "minitest/autorun"
require "rack/test"

require_relative "../data/recipe.rb"

class RecipeAppTest < Minitest::Test
  def test_create_recipe
    recipe = Recipe.new(nil, "name", "30 min")

    assert(recipe.is_a?(Recipe))
  end
end
