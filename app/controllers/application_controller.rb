
require_relative '../../config/environment'
require 'pry'
class ApplicationController < Sinatra::Base

	configure do
		register Sinatra::ActiveRecordExtension
    	set :views, Proc.new { File.join(root, "../views/") }
    	enable :sessions unless test?
   		set :session_secret, "secret"
  	end

  	get '/' do 
  		if session[:birder_id] && Birder.find_by_id(session[:birder_id])
  			@current_user = Birder.find_by_id(session[:birder_id])
  			erb :homepage
  		else
  			puts Birder.find_by_id(session[:birder_id])
  			erb :index
  		end
  	end 

  	post '/' do 
  		sightings = []
  		params[:birds].each do |bird|
  			reified_bird = Bird.find_by({common_name: bird})
			sighting = Sighting.create({bird_id: reified_bird.id, checklist_id: session[:checklist_id]})
			sightings << sighting
		end
		redirect "/checklists/current"
	end  		

  	get '/login' do 
  		erb :login
  	end

  	get '/logout' do
  		session.clear
  		redirect '/'
  	end

	helpers do
		def is_logged_in?(session_hash)
			if session_hash[:birder_id] && Birder.find_by_id(session_hash[:birder_id])
				return true 
			else 
				return false
			end
		end
		def convert_time(param_hash)
			if param_hash[:timeofday] == "pm"
				param_hash[:hours] = (param_hash[:hours].to_i + 12).to_s
			end
			if param_hash[:hours].length == 1
				param_hash[:hours] = "0" + param_hash[:hours].to_s
			end
			if param_hash[:minutes].length == 1
				param_hash[:minutes] = "0" + param_hash[:hours].to_s
			end
			"#{param_hash[:hours]}:#{param_hash[:minutes]}"
		end
	end
end
