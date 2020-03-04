require "minitest/autorun"
require "mocha/minitest"
require "./lib/curator"


class CuratorTest < Minitest::Test

  def test_it_exists
    assert_instance_of Curator, Curator.new
  end

  
end
