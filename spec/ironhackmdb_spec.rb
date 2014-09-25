require_relative '../ironhackmdb'

	describe 'ronhackmdb' do	
		before do
	    @tvshow = TVShow.new
	    @tvshow.name = "Simpsons"
	    @tvshow.own_rating = 3
	    @tvshow.own_comments = "vaya me"
		end
		it "checks if an empty name is returning invalid" do
			@tvshow.name = ""
			expect(@tvshow.valid?).to eq (false)
		end
		it "The our_rating field should be present and between 0 and 10 (both included)" do
			@tvshow.own_rating = 12
			expect(@tvshow.valid?).to eq (false)
		end
		it "The our_comments field should be present, with more than 100 characters but less than 10000" do
			@tvshow.own_comments = "no me gusta"
			expect(@tvshow.valid?).to eq (false)
		end

	end