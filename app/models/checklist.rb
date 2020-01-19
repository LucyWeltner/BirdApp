class Checklist < ActiveRecord::Base
	validates :temperature, presence: true, numericality: { only_integer: true }
	belongs_to :birder 
	belongs_to :location
	belongs_to :day
	has_many :sightings
	has_many :birds, through: :sightings
end