require 'rubygems'
require 'active_record'
require 'sinatra'
require 'sinatra/reloader'
#require 'sinatra/flash'
# require 'date'
#require "pry"
require 'imdb'
#require_relative 'List'
set :port, 3000
set :bind, '0.0.0.0'


ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: 'ironhackmdb.sqlite'
)


class TVShow < ActiveRecord::Base
		
  validates_presence_of :name, :own_rating, :own_comments   
  validates_uniqueness_of :name
	validates :own_rating, numericality: true, inclusion: {in: (0..10)}
	validates :own_comments, length: {in: 10..10000}	


	def get_imdb_data  #returns array of four elements with Imdb info
			movie = Imdb::Search.new(name).movies.first		
			serie = Imdb::Serie.new(movie.id)
			return [movie.rating, serie.seasons.count, serie.url, movie.poster]
	end

end

get '/' do
	@list = TVShow.all
	erb :index  
end

get '/our_ranking' do
	@list =TVShow.all
	erb :our_ranking
end

get '/imdb_ranking' do
	@list = []
	TVShow.all.each do |tvshow|
		@list << [tvshow, tvshow.get_imdb_data ]
	end
	erb :imdb_ranking
end


post '/' do
	if params[:action] == 'add'
		myshow=TVShow.create(name: params[:show], own_comments: params[:comments], own_rating: params[:rating].to_i)
		myshow.save 
#		binding.pry
		if myshow.valid? 
			@list = TVShow.all
			erb :index
		else
			@errors = []
			myshow.errors.each do |attr, err| 
				@errors << "#{attr} - #{err}"
			end
			erb :error
		end
	end
end	



__END__
