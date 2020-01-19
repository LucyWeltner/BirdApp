
require_relative '../../config/environment'
class BirdController < ApplicationController
	get '/birds/:id' do 
		@bird = Bird.find_by_id(params[:id])
		if @bird
			erb :'birds/show'
		end
	end
end