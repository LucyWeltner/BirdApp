
require_relative '../../config/environment'
class LocationController < ApplicationController
	get '/locations/search' do 
		erb :'locations/search'
	end

	post '/locations/results' do 
		query = params[:local_query]
		@locals = Location.all.select{|local| local.name.include?(query)}
		erb :'locations/results'
	end

	get '/locations/:id' do
		@local = Location.find_by_id(params[:id])
		@birds = @local.birds.uniq
		erb :'locations/show'
	end

end