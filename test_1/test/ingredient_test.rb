ENV["RACK_ENV"] = "test"

require 'sinatra'
require_relative '../data/database_persistance.rb'

DB = DatabasePersistance.new

require "minitest/autorun"
require "minitest/reporters"

Minitest::Reporters.use!

require 'simplecov'
SimpleCov.start

require_relative "../data/ingredient.rb"

class IngredientTest < Minitest::Test
  def test_create_ingredient_instance
    ingredient = Ingredient.new(nil, "name", 1)

    assert(ingredient.is_a?(Ingredient))
  end
end
