require "minitest/autorun"
require "mocha/minitest"
require "./lib/artist"


class ArtistTest < Minitest::Test

  def test_it_exists
    assert_instance_of Artist, Artist.new({})
  end

end
