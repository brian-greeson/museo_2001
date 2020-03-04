require "minitest/autorun"
require "mocha/minitest"
require "./lib/curator"


class CuratorTest < Minitest::Test

  def test_it_exists
    assert_instance_of Curator, Curator.new
  end

  def test_it_starts_with_no_photos
    curator = Curator.new 
    assert_equal [], curator.photographs
  end


end
