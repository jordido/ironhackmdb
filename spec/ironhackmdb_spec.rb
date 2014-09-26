require_relative '../ironhackmdb'

	describe 'ronhackmdb' do	
		before do
	    @tvshow = TVShow.new
	    @tvshow.name = "Simpsons"
	    @tvshow.own_rating = 3
	    @tvshow.own_comments = "vaya me de serie tio"
		end
		describe "INITIAL values" do
			it "Initial values are correct" do
				expect(@tvshow.valid?).to eq(true)
			end
		end
		describe :name do
			it "checks if an empty name is returning invalid" do
				@tvshow.name = ""
				expect(@tvshow.valid?).to be_falsy
			end
		end
		describe :own_rating do
			it "The our_rating field should be present and between 0 and 10 (both included)" do
				@tvshow.own_rating = 11
				expect(@tvshow.valid?).to be_falsy
			end
		end
		describe :our_comments do
			it "The our_comments field should be present, with more than 100 characters but less than 10000" do
				@tvshow.own_comments = "no me va"
				expect(@tvshow.valid?).to be_falsy
			end
		end
		describe 'ImdbCheckings' do
			describe :rating do
				it "rating is a numeric value" do
					expect(@tvshow.get_imdb_rating('')).is_a? Integer 
				end
			end
		end

	end