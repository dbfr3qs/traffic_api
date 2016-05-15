class Api::V1::EtasController < ApplicationController
	respond_to :json
	
	def index
		render json: Database.return_data('Porirua'), status: 200
	end

	def create
		#logger.info params
		@params = params
		puts @params["suburb"]
		render json: Database.return_data(@params["suburb"]), statis: 201
	end
end
