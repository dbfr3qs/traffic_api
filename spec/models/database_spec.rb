require 'rails_helper'
require 'database'

RSpec.describe Database, :type => :model do
	context "When given valid arguments" do
		it "returns a 2 dimensional array of data" do
			data = Database.return_data('Porirua', 'PM', 'May')
			expect(data).to be_an(Array)
		end
	end
end
