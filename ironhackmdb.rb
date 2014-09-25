require 'rubygems'
require 'active_record'
require 'sinatra'
require 'sinatra/reloader'
require 'date'
require "pry"
require 'imdb'
require_relative 'List'
set :port, 3000
set :bind, '0.0.0.0'


ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: 'ironhackmdb.sqlite'
)
#config.i18n.enforce_available_locales = true
class TVShow < ActiveRecord::Base
	
	#The name field should be present, and unique across all our TV shows.
 	#The our_rating field should be present and between 0 and 10 (both included)
	#The our_comments field should be present, with more than 100 characters but less than 10000
	
  validates_presence_of :name, :own_rating, :own_comments   
  validates_uniqueness_of :name
	validates :own_rating, numericality: true, inclusion: {in: (0..10)}
	validates :own_comments, length: {in: 10..10000}	
#	attr_accessor :imdb_rating

	# def initialize
	# 	@imdb_rating = get_imdb_rating ('Friends')
	# end

	private

	def get_imdb_rating (name)
		rating = Imdb::Search.new(name).movies.first.rating
	end

end

list_of_shows ||= TVShow.all

get '/' do
	@list = list_of_shows
	erb :index  # goes to views folder and looks for the file index.erb (html)
end

post '/' do

	if params[:action] == 'add'
		if list_of_songs.songs.size < 5
			list_of_songs.add_song(params[:artist], params[:song])
		  @list = list_of_songs.songs
			erb :index
		else
			redirect to('/enough')
		end
	end	
end


__END__
