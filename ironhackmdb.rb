require 'rubygems'
require 'active_record'
require 'sinatra'
require 'sinatra/reloader'
#require 'sinatra/flash'
require 'date'
require "pry"
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

	private

	def get_imdb_rating (name)
		rating = Imdb::Search.new(name).movies.first.rating
	end

end


get '/' do
	@list = TVShow.all
	erb :index  
end

post '/' do
	if params[:action] == 'add'
		my_show = params[:show]
		my_comments = params[:comments]
		my_rating = params[:rating]
	
		myshow=TVShow.create(name: my_show, own_comments: my_comments, own_rating: my_rating.to_i)
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
#			flash[:error] = @errors
			erb :error
		end
		
	else
	end	
end


__END__
