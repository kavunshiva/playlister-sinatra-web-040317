class Artist < ActiveRecord::Base
  has_many :songs
  has_many :genres, through: :songs

  # use slugs module
  include Slugs::MakeSlug
  extend Slugs::FindSlug
end
