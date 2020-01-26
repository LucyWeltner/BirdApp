
require_relative '../../config/environment'
class ChecklistController < ApplicationController
	get '/checklists' do 
		if is_logged_in?(session)
			@checklists = current_birder(session).checklists
			erb :'/checklists/index'
		end
	end

	post '/checklists' do
		@region = Region.find_by_id(params[:region])
		checklist = Checklist.new(params[:checklist])
		checklist.birder_id = session[:birder_id]
		location = Location.find_or_create_by({name: params[:location], region_id: @region.id})
		checklist.location_id = location.id 
		times = {start: convert_time(params[:start]), end: convert_time(params[:stop])}
		checklist.start_time = times[:start] 
		checklist.end_time = times[:end] 
		if !checklist.save
			@errors = checklist.errors
			erb :'failed_login'
		else
			session[:checklist_id] = checklist.id
			erb :'birds/index'
		end
	end

	get '/checklists/new' do 
		@regions = Region.all
		erb :'/checklists/new'
	end

	get '/checklists/current' do 
		@checklist = Checklist.find_by_id(session[:checklist_id])
		erb :'/checklists/current'
	end

	get '/checklists/:id' do
		@checklist = Checklist.find_by_id(params[:id])
		erb :'checklists/show'
	end

	patch '/checklists/:id' do
		@checklist = Checklist.find_by_id(params[:id])
		params[:birds].each do |birds_id|
			if !Sighting.find_by({checklist_id: @checklist.id, bird_id: birds_id})
				Sighting.create({checklist_id: @checklist.id, bird_id: birds_id})
			end
		end
		erb :'checklists/show'
	end

	delete '/checklists/:id' do 
		checklist = Checklist.find_by_id(params[:id])
		checklist.destroy
		redirect '/checklists'
	end


	get '/checklists/:id/edit' do 
		@checklist = Checklist.find_by_id(params[:id])
		if @checklist 
			@birder = current_birder(session)
			if @birder.checklists.find_by_id(@checklist.id)
				erb :'checklists/edit'
			else 
				@errors = [["You cannot edit a checklist you did not make."]] 
				erb :'failed_login'
			end 
		else 
			@errors = [["There is no checklist with this ID."]] 
			erb :'failed_login'
		end
	end
end