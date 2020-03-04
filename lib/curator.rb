require "./lib/photograph"
require "./lib/artist"
require "CSV"

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

  def photographs_taken_by_artist_from(country)
    artists_photos = photographs_by_artist.select do |artist, photos|
      artist.country == country
    end
    artists_photos.values.flatten
  end

  def load_photographs(filepath)
    CSV.foreach(filepath, {headers: true, header_converters: :symbol}) do |row|
      @photographs << Photograph.new(row.to_hash)
    end
  end

  def load_artists(filepath)
    CSV.foreach(filepath, {headers: true, header_converters: :symbol}) do |row|
      @artists << Artist.new(row.to_hash)
    end
  end

  def photographs_taken_between(range)
    @photographs.find_all do |photo|
      range.include?(photo.year.to_i)
    end
  end

end
