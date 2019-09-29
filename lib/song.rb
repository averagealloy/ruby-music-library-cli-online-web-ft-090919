class Song
extend Concerns::Findable

  attr_accessor :name, :artist, :genre
  @@all = []

  def initialize(name, artist = nil, genre = nil)
    @name = name
    self.artist = artist if artist !=nil
    self.genre = genre if genre != nil
    save
  end

  def self.all
    @@all
  end

  def self.destroy_all
    @@all.clear
  end

  def save
      @@all << self
  end

  def self.create(name)
    Song.new(name)
  end

  def artist=(name)
    @artist = name
    name.add_song(self)
  end

  def genre=(genre)
    @genre = genre
    genre.songs << self unless genre.songs.include? self
  end



  def self.find_or_create_by_name(name)
    find_by_name(name) || create(name)
  end


  def self.new_from_filename(file_name)
     artist = file_name.split(" - ")[0]
     title = file_name.split(" - ")[1]
     genre = file_name.split(" - ")[2].chomp(".mp3")

     song = Song.find_or_create_by_name(title)
     artist = Artist.find_or_create_by_name(artist)
     genre = Genre.find_or_create_by_name(genre)

     song.artist = artist
     song.genre = genre
     song
   end

   def self.create_from_filename(filename)
     new_from_filename(filename)
   end


end
