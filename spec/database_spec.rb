require 'spec_helper'
#require_relative '../app/models/database'

RSpec.describe Database do
	it "returns a 2 dimensional array of data" do
		data = Database.return_data()
		expect(data).to be_an(Array)
	end
end