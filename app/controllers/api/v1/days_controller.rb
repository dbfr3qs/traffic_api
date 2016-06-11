class Api::V1::DaysController < ApplicationController
	respond_to :json
	
	def index
		render json: Database.return_data('Porirua'), status: 200
	end

	def create
		#logger.info params
		@params = params
		#puts @params["suburb"]
		#puts @params["period"]
		#puts @params["month"]
		render json: Database.return_data_by_day(@params["suburb"], @params["period"], @params["month"], @params["day"]), statis: 201
	end
end