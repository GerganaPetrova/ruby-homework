class Song
  attr_reader :name, :artist, :album

  def initialize(name, artist, album)
    @name = name
    @artist = artist
    @album = album
  end
end

class Collection
  include Enumerable
  attr_reader :songs

  def initialize(songs)
    @songs = songs
  end

  def Collection.parse(text)
    songs_data = text.split(/\n+/).each_slice(3)
    Collection.new(songs_data.map { |song_data| Song.new(*song_data) })
  end

  def each
    @songs.each { |song| yield song }
  end

  def albums
    @songs.map { |song| song.album }.uniq
  end

  def names
    @songs.map { |song| song.name }.uniq
  end

  def artists
    @songs.map { |song| song.artist }.uniq
  end

  def filter(criterion)
    Collection.new(@songs.select { |song| criterion.matches?(song) })
  end

  def adjoin(collection)
    Collection.new(@songs + collection.songs)
  end
end

module LogicalOperations

  def &(other)
    CriteriaConjuction.new([self,other])
  end

  def |(other)
    CriteriaDisjunction.new([self,other])
  end

  def !
    CriteriaNegative.new([self])
  end
end

class CriteriaConjuction
  include LogicalOperations

  def initialize(criteria)
    @criteria = criteria
  end

  def matches?(song)
    @criteria.all? { |criterion| criterion.matches?(song) }
  end
end

class CriteriaDisjunction
  include LogicalOperations

  def initialize(criteria)
    @criteria = criteria
  end

  def matches?(song)
    @criteria.any? { |criterion| criterion.matches?(song) }
  end
end

class CriteriaNegative
  include LogicalOperations

  def initialize(criteria)
    @criteria = criteria
  end

  def matches?(song)
    @criteria.none? { |criterion| criterion.matches?(song) }
  end
end

class AlbumCriteria
  include LogicalOperations

  def initialize(album)
    @album = album
  end

  def matches?(song)
   @album == song.album
  end
end

class ArtistCriteria
  include LogicalOperations

  def initialize(artist)
    @artist = artist
  end

  def matches?(song)
   @artist == song.artist
  end
end

class NameCriteria
  include LogicalOperations

  def initialize(name)
    @name = name
  end

  def matches?(song)
   @name == song.name
  end
end

class Criteria
  include LogicalOperations

  def Criteria.name(name)
    NameCriteria.new(name)
  end

  def Criteria.artist(artist)
   ArtistCriteria.new(artist)
  end

  def Criteria.album(album)
    AlbumCriteria.new(album)
  end
end
