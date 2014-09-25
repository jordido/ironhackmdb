require 'rubygems'
require 'active_record'
require 'sinatra'
require 'sinatra/reloader'
require 'date'
require "pry"


ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: 'ironhackmdb.sqlite'
)

class TVShow < ActiveRecord::Base

	#The name field should be present, and unique across all our TV shows.
 	#The our_rating field should be present and between 0 and 10 (both included)
	#The our_comments field should be present, with more than 100 characters but less than 10000
	
  validates_presence_of :name, :own_rating, :own_comments   
  validates_uniqueness_of :name
	validates_numericality_of :own_rating, only_integer: {in: 0..10}
	validates :own_comments, length: {in: 100..10000}	
	# validate :size_of_comments

	private

	# def size_of_comments
	# 	if own_comments.size < 100  || own_comments.size > 1000
	# 		errors.add(:own_comments, 'Comments size must be between 100 and 1000 characters')
	# 	else
	# 		return true
	# 	end
	# end

end

tvshow = TVShow.new
tvshow.name = "Simpsons"
tvshow.own_rating = 3
tvshow.own_comments = "vaya me"
p tvshow.own_comments.size