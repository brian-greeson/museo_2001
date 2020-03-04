require "minitest/autorun"
require "mocha/minitest"
require "./lib/photograph"


class PhotographTest < Minitest::Test

  def test_it_exists
    attributes = mock
    assert_instance_of Photograph, Photograph.new(attributes)
  end

end
