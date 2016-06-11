require 'sequel'
require 'item'
require 'pry'

class Database
	attr_accessor :DB 
	attr_accessor :etas

	def self.get_items(suburb)
		@DB = Sequel.connect('sqlite://data.db')
		@etas = @DB[:etas]
		set = @etas.where(:suburb => suburb)
		items = Array.new
			# create array of items (eta objects)
		set.each do |record|
			time = Time.parse(record[:time])
			item = Item.new(time.day, time.month, time.year, time.hour, time.min, time.sec, record[:eta], record[:suburb])
			items << item
		end
		items
	end

	def self.get_day(day, month, suburb, period)
		items = self.get_items(suburb)
		if period == "AM"
			items = items.select { |item| item.day == day.to_i && item.month == month.to_i && item.hour < 12 }
		else 
			items = items.select { |item| item.day == day.to_i && item.month == month.to_i && item.hour > 12 }
		end	
	end

	def self.return_data_by_day(suburb, period, month, day)
		items = self.get_day(day, month, suburb, period)

		times = items.map { |item| item.hour.to_s + ":" + item.min.to_s }

		items = items.map { |item| item.eta }

		return times, items
	end

	def self.return_data_by_month(suburb, period, month) # display averages for a month
		items = self.get_items(suburb)
		@month = month

		# get the days in April that we have data for
		days = items.select { |item| item.month == @month.to_i }.map { |item| item.day.to_i }.uniq
		days.sort!.reverse!
		averages = Array.new
		data = Array.new

		# calculate average eta for each day
		days.each do |day|
			if period == "AM"
				data = items.select { |item| item.day == day && item.month == @month.to_i && item.hour.to_i < 12 }.map { |record| record.eta.to_i } # get etas
			else 
				data = items.select { |item| item.day == day && item.month == @month.to_i && item.hour.to_i >12 }.map { |record| record.eta.to_i } # get etas	
			end

			unless data.count == 0 
				averages << (data.inject(0) { |sum, x| sum + x}) / data.count
			end
		end
  		
		# get the actual day, mon tues, wed, etc
		def self.dayOfWeek(day) 
			theDate = Date.new(2016, @month.to_i, day)
			theDate.strftime('%a')
		end
		
		dayNames = Array.new
		days.each do |day|
			dayNames << dayOfWeek(day) + " " + day.to_s
		end
		
		return dayNames.reverse, averages.reverse
	end
end