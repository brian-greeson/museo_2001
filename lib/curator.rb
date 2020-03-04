require "./lib/photograph"
require "./lib/artist"

class Curator
  attr_reader :photographs, :artists

  def initialize()
    @photographs = []
    @artists = []
  end

  def add_photograph(photo)
    @photographs << photo
  end

  def add_artist(artist)
    @artists << artist
  end


  def find_artist_by_id(id)
    @artists.find { |artist| artist.id == id  }
  end

  def photographs_by_artist
    @artists.reduce({}) do |photo_by_artists, artist|
      photo_by_artists[artist] = @photographs.find_all do |photo|
        photo.artist_id == artist.id
      end
      photo_by_artists
    end
  end

  def artists_with_multiple_photographs
    artists = photographs_by_artist.select { |artist, photos| photos.length > 1 }
    artists.keys.map { |artist| artist.name }
  end

end
