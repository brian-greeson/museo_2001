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

  def test_it_starts_without_artists
      curator = Curator.new

      assert_equal [], curator.artists
  end

  def test_it_can_add_artists
    curator = Curator.new
    artist_1 = Artist.new({
                            id: "1",
                            name: "Henri Cartier-Bresson",
                            born: "1908",
                            died: "2004",
                            country: "France"
                        })
    artist_2 = Artist.new({
                            id: "2",
                            name: "Ansel Adams",
                            born: "1902",
                            died: "1984",
                            country: "United States"
                        })

    curator.add_artist(artist_1)
    curator.add_artist(artist_2)

    assert_equal [artist_1, artist_2], curator.artists
  end

  def test_it_can_find_artist_by_id
    curator = Curator.new
    artist_1 = Artist.new({
                            id: "1",
                            name: "Henri Cartier-Bresson",
                            born: "1908",
                            died: "2004",
                            country: "France"
                        })
    artist_2 = Artist.new({
                            id: "2",
                            name: "Ansel Adams",
                            born: "1902",
                            died: "1984",
                            country: "United States"
                        })

    curator.add_artist(artist_1)
    curator.add_artist(artist_2)

    assert_equal artist_1, curator.find_artist_by_id("1")
    assert_equal artist_2, curator.find_artist_by_id("2")
    assert_nil curator.find_artist_by_id("3")
  end

  def test_it_can_list_photos_by_artist
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
    photo_3 = Photograph.new({
         id: "3",
         name: "Identical Twins, Roselle, New Jersey",
         artist_id: "3",
         year: "1967"
    })
    photo_4 = Photograph.new({
         id: "4",
         name: "Monolith, The Face of Half Dome",
         artist_id: "3",
         year: "1927"
    })
    artist_1 = Artist.new({
         id: "1",
         name: "Henri Cartier-Bresson",
         born: "1908",
         died: "2004",
         country: "France"
    })
    artist_2 = Artist.new({
         id: "2",
         name: "Ansel Adams",
         born: "1902",
         died: "1984",
         country: "United States"
    })
    artist_3 = Artist.new({
         id: "3",
         name: "Diane Arbus",
         born: "1923",
         died: "1971",
         country: "United States"
    })
    curator.add_artist(artist_1)
    curator.add_artist(artist_2)
    curator.add_artist(artist_3)
    curator.add_photograph(photo_1)
    curator.add_photograph(photo_2)
    curator.add_photograph(photo_3)
    curator.add_photograph(photo_4)

    expected = {
                 artist_1 => [photo_1],
                 artist_2 => [photo_2],
                 artist_3 => [photo_3,photo_4]
               }

    assert_equal expected, curator.photographs_by_artist
  end

  def test_it_lists_artist_with_multiple_photos
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
    photo_3 = Photograph.new({
         id: "3",
         name: "Identical Twins, Roselle, New Jersey",
         artist_id: "3",
         year: "1967"
    })
    photo_4 = Photograph.new({
         id: "4",
         name: "Monolith, The Face of Half Dome",
         artist_id: "3",
         year: "1927"
    })
    artist_1 = Artist.new({
         id: "1",
         name: "Henri Cartier-Bresson",
         born: "1908",
         died: "2004",
         country: "France"
    })
    artist_2 = Artist.new({
         id: "2",
         name: "Ansel Adams",
         born: "1902",
         died: "1984",
         country: "United States"
    })
    artist_3 = Artist.new({
         id: "3",
         name: "Diane Arbus",
         born: "1923",
         died: "1971",
         country: "United States"
    })
    curator.add_artist(artist_1)
    curator.add_artist(artist_2)
    curator.add_artist(artist_3)
    curator.add_photograph(photo_1)
    curator.add_photograph(photo_2)
    curator.add_photograph(photo_3)
    curator.add_photograph(photo_4)

    assert_equal ["Diane Arbus"], curator.artists_with_multiple_photographs
  end

  def test_it_photos_taken_by_artists_in_country
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
    photo_3 = Photograph.new({
         id: "3",
         name: "Identical Twins, Roselle, New Jersey",
         artist_id: "3",
         year: "1967"
    })
    photo_4 = Photograph.new({
         id: "4",
         name: "Monolith, The Face of Half Dome",
         artist_id: "3",
         year: "1927"
    })
    artist_1 = Artist.new({
         id: "1",
         name: "Henri Cartier-Bresson",
         born: "1908",
         died: "2004",
         country: "France"
    })
    artist_2 = Artist.new({
         id: "2",
         name: "Ansel Adams",
         born: "1902",
         died: "1984",
         country: "United States"
    })
    artist_3 = Artist.new({
         id: "3",
         name: "Diane Arbus",
         born: "1923",
         died: "1971",
         country: "United States"
    })
    curator.add_artist(artist_1)
    curator.add_artist(artist_2)
    curator.add_artist(artist_3)
    curator.add_photograph(photo_1)
    curator.add_photograph(photo_2)
    curator.add_photograph(photo_3)
    curator.add_photograph(photo_4)

    expected = [photo_2, photo_3, photo_4]

    assert_equal expected, curator.photographs_taken_by_artist_from("United States")
    assert_equal [], curator.photographs_taken_by_artist_from("Argentina")
  end

  def test_it_can_load_photos_from_file
    curator = Curator.new
    curator.load_photographs('./data/photographs.csv')

    assert_equal 4, curator.photographs.length
    assert_equal "Moonrise, Hernandez", curator.photographs[1].name
  end

  def test_it_can_load_artists_from_file
    curator = Curator.new

    curator.load_artists('./data/artists.csv')

    assert_equal 6, curator.artists.length
    assert_equal "Ansel Adams", curator.artists[1].name
  end
end
