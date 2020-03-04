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

end
