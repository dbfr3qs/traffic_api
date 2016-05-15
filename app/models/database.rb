require 'sequel'
require 'item'
require 'pry'

class Database
	attr_accessor :DB 
	attr_accessor :etas

	def self.return_data(suburb)
		@DB = Sequel.connect('sqlite://data.db')
		@etas = @DB[:etas]
		set = @etas.where(:suburb => suburb)
		items = Array.new
			# create array of items (eta objects)
		set.each do |record|
			time = Time.parse(record[:time])
			item = Item.new(time.day, time.month, time.year, time.hour, time.min, time.sec, record[:eta], record[:suburb])
			#puts item.hour
			items << item
		end

		# get the days in April that we have data for
		days = items.select { |item| item.month == 4 }.map { |item| item.day.to_i }.uniq
		averages = Array.new
		data = Array.new

		# calculate average eta for each day
		days.each do |day|
			data = items.select { |item| item.day == day && item.month == 4 && item.hour.to_i < 12 }.map { |record| record.eta.to_i } # get etas
			unless data.count == 0 
				averages << (data.inject(0) { |sum, x| sum + x}) / data.count
			end
		end

		def self.dayOfWeek(day) 
			theDate = Date.new(2016, 4, day)
			theDate.strftime('%a')
		end
		
		dayNames = Array.new
		days.each do |day|
			dayNames << dayOfWeek(day) + " " + day.to_s 
		end

		return dayNames.reverse, averages.reverse
	end
end