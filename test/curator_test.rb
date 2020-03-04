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

  def test_it_can_add_photos
    curator = Curator.new

    photo_1 = Photograph.new({
                              id: "1",
                              name: "Rue Mouffetard, Paris (Boy with Bottles)",
                              artist_id: "1",
                              year: "1954"
                            })

    photo_2 = Photograph.new({
                              id: "2",
                              name: "Moonrise, Hernandez",
                              artist_id: "2",
                              year: "1941"
                            })

    curator.add_photograph(photo_1)
    curator.add_photograph(photo_2)

    assert_equal [photo_1, photo_2], curator.photographs
  end

end
