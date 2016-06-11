require 'rails_helper'
require 'database'
require 'pry'

RSpec.describe Database, :type => :model do
	
	context "When given valid arguments" do
		it "return_data_by_month returns a 2 dimensional array of data" do
			data = Database.return_data_by_month('Porirua', 'PM', 5)
			expect(data).to be_an(Array)
			expect(data.length).to eq(2)
		end
	end

	context "When given valid arguments" do
		it "get_day returns a valid array of data" do
			data = Database.get_day('18', 5, 'Porirua', 'PM')
			
			data.each do |item|
				expect(item.day).to be('18'.to_i)
			end

			expect(data).to be_an(Array)
		end
	end

	context "When given valid arguments" do
		it "return_data_by_day returns a valid 2 dimensional array of data" do
			data = Database.return_data_by_day('Porirua', 'PM', 5, '18')

			data[0].each do |time|
				expect(time[0,2].to_i).to be > 12
			end
			
			expect(data).to be_an(Array)
			expect(data.length).to eq(2)
		end
	end
end


