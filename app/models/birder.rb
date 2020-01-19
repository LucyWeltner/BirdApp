class Birder < ActiveRecord::Base
	has_secure_password
	validates_uniqueness_of :name
	validates :name, presence: true
	validates :email, presence: true
	validates :password, presence: true
	has_many :checklists 
	has_many :sightings, through: :checklists 
	has_many :birds, through: :sightings
end
