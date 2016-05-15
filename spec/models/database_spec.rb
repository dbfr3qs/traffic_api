require 'rails_helper'
require 'database'

RSpec.describe Database do
	describe '#return_data' do
		it "returns a 2 dimensional array of data" do
			data = Database.return_data()
			expect(data).to be_an(Array)
		end
	end
end

RSpec.describe Database do
	describe '#return_data(attributes)' do
		it "returns an array according to attributes" do
			data = Database.return_data(attributes)
			expect(data).to be_an(Array)
		end
	end
end