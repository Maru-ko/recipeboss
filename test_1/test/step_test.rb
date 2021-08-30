require "minitest/autorun"
require "minitest/reporters"

Minitest::Reporters.use!

require 'simplecov'
SimpleCov.start

require_relative "../data/step.rb"

class StepTest < Minitest::Test
  def test_create_step_instance
    step = Step.new(nil, "name", 2)

    assert(step.is_a?(Step))
  end
end
