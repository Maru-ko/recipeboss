ENV["RACK_ENV"] = "test"

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
  def setup
    DB.query("DROP SCHEMA IF EXISTS public CASCADE;")
    DB.query("CREATE SCHEMA public;")

    file_path = File.expand_path("../test/schema.sql", __FILE__)
    sql = File.open(file_path, 'rb') { |file| file.read }
    DB.execute(sql)
  end

  def test_create_recipe_instance
    sql = "INSERT INTO recipes (name, cook_time)  VALUES ('name', '30')"
    DB.query(sql)

    recipe = Recipe.new(nil, "name", "30")
    assert(recipe.is_a?(Recipe))
  end

  def test_find_recipe_at_id
    sql = "INSERT INTO recipes (name, cook_time)  VALUES ('pasta', '30')"
    DB.query(sql)

    recipe = Recipe.find(1);

    assert_equal("wrong name", recipe.name)
    assert_equal(1, recipe.id)
  end

  def teardown
    DB.query("DROP SCHEMA IF EXISTS public CASCADE;")
  end
end
