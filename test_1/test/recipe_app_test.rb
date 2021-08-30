require "minitest/autorun"
require "minitest/reporters"
require "rack/test"
Minitest::Reporters.use!

require_relative "../recipe_app.rb"

class RecipeAppTest < Minitest::Test
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  def test_index
    get '/'

    assert_equal 200, last_response.status
    assert_equal "text/html;charset=utf-8", last_response["Content-Type"]
    assert_includes last_response.body, "<p><strong>“Hello World”</strong>"
  end
end
