class List
	def initialize
		@list = []
	end

	def add(element)
		@list << element
	end

	def print
		index = 1
		@list.each do |element|
			puts index.to_s + ". " + element
			index += 1
		end
	end
end