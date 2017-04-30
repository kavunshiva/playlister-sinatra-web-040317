class Genre < ActiveRecord::Base
  has_many :song_genres
  has_many :songs, through: :song_genres
  has_many :artists, through: :songs

  # use slugs module
  include Slugs::MakeSlug
  extend Slugs::FindSlug
end
