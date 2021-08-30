require "minitest/autorun"
require "minitest/reporters"

Minitest::Reporters.use!

require 'simplecov'
SimpleCov.start

require_relative "../data/recipe.rb"

class RecipeTest < Minitest::Test
  def test_create_recipe_instance
    recipe = Recipe.new(nil, "name", "30 min")

    assert(recipe.is_a?(Recipe))
  end
end
