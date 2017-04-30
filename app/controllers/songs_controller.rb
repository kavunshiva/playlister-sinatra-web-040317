class SongsController < ApplicationController

  def modify_songs_artists_and_genres
    if params["song"]["artist"].present?
      @artist = Artist.find_or_create_by(name: params["song"]["artist"])
      @song.artist = @artist
    end
    @song.genres.clear
    if !!params["song"]["genre_ids"]
      params["song"]["genre_ids"].each do |genre_id|
        @song.genres << Genre.find(genre_id)
      end
    end
    @song.save
    redirect to "/songs/#{@song.slug}"
  end

  get '/songs/new' do
    @genres = Genre.all
    erb :'songs/new'
  end

  get '/songs/:slug/edit' do
    @song = Song.find_by_slug(params["slug"])
    @genres = Genre.all
    erb :'songs/edit'
  end

  get '/songs/:slug' do
    @song = Song.find_by_slug(params["slug"])
    erb :'songs/show'
  end

  patch '/songs/:slug' do
    @song = Song.find_by_slug(params["slug"])
    if params["song"]["name"].present?
      @song.name = params["song"]["name"]
    end
    modify_songs_artists_and_genres
  end

  get '/songs' do
    @songs = Song.order(:name)
    erb :'songs/index'
  end

  post '/songs' do
    @song = Song.create(name: params["song"]["name"])
    modify_songs_artists_and_genres
  end
end
