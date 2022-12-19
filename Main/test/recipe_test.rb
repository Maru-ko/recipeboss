require 'sinatra'
require_relative '../data/database_persistance.rb'

DB = DatabasePersistance.new

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

  def test_find_recipe_at_id
    recipe = Recipe.find(1);

    assert_equal("pasta", recipe.name)
    assert_equal(1, recipe.id)
  end
end
