class Location < ActiveRecord::Base
	has_many :checklists
	has_many :sightings, through: :checklists 
	has_many :birds, through: :sightings 
	belongs_to :region
end