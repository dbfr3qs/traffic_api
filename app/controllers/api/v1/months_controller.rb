class Api::V1::MonthsController < ApplicationController
	respond_to :json
	
	def index
		render :text => "404 Not Found", :status => 404
	end

	def create
		@params = params
		render json: Database.return_data_by_month(@params["suburb"], @params["period"], @params["month"]), status: 201
	end
end