
require_relative '../../config/environment'
class BirderController < ApplicationController
		get '/birders/new' do
  		# if !is_logged_in?(session)
  		erb :'birders/new'
  	end

  	post '/birders/new' do
  		current_user = Birder.new(params[:birder])
      if current_user.save
        session[:birder_id] = current_user.id
        redirect '/'
      else
        @errors = current_user.errors
        erb :'failed_login'
      end
  	end

  	post '/birders' do 
  		birder = Birder.find_by({name: params[:name]})
  		if birder && birder.authenticate(params[:password])
  			session[:birder_id] = birder.id
  			redirect '/'
  		else 
        @errors = [["Username or password does not exist"]]
  			erb :'failed_login'
  		end
  	end

  	get '/birders/profile' do 
  		if is_logged_in?(session)
  			@current_user = Birder.find_by_id(session[:birder_id])
  			erb :'birders/profile'
  		else 
        @errors = [["You are not logged in!"]]
  			erb :'failed_login'
  		end
  	end

  	get '/birders/:id' do 
  		@found = Birder.find_by_id(params[:id])
  		if @found
  			if @found.id == session[:birder_id]
  				@current_user = @found
  				erb :'birders/profile'
  			else
  				erb :'birders/show'
  			end
  		else
        @errors = [["There is no user with this ID"]]
  			erb :'failed_login'
  		end
  	end

  	get '/birders/:id/checklists' do 
  		found = Birder.find_by_id(params[:id])
  		if found
  			@checklists = found.checklists
  			if found.id == session[:birder_id]
  				erb :'/checklists/index'
  			else
  				erb :'birders/show_checklists'
  			end
  		else
        @errors = [["There is no checklist with this ID"]]
  			erb :'failed_login'
  		end
  	end

  	get '/birders/:id/lifelist' do 
  		@found = Birder.find_by_id(params[:id])
  		if @found
  			@birds = @found.birds.uniq
  			if @found.id == session[:birder_id]
  				erb :'birders/your_lifelist'
  			else
  				erb :'birders/show_lifelist'
  			end
  		else 
        @errors = [["There is no user with this ID"]]
  			erb :'failed_login'
  		end 
  	end 
end