require 'rails_helper'

RSpec.describe Api::V1::DaysController, :type => :controller do
	describe "POST create with valid parameters" do
		it "returns a 200 status code" do
			post :create, :suburb => 'Porirua', :month => 5, :day => '18', :period => 'PM'

			expect(response).to have_http_status(201)
		end
	end

	describe "GET index" do
		it "returns 404 not found" do
			get :index

			expect(response).to have_http_status(404)
		end
	end
end

RSpec.describe Api::V1::MonthsController, :type => :controller do
	describe "POST create with valid parameters" do
		it "returns a 200 status code" do
			post :create, :suburb => 'Porirua', :month => 5, :period => 'PM'

			expect(response).to have_http_status(201)
		end
	end

	describe "GET index" do
		it "returns 404 not found" do
			get :index

			expect(response).to have_http_status(404)
		end
	end
end
