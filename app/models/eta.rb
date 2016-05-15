require 'database'

class Eta
	
	attr_accessor :data
	attr_accessor :dataset

	def initialize()
		@data = Database.new
		@dataset = @data.return_data()
	end	
end