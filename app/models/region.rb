class Region < ActiveRecord::Base
	has_many :locations
	has_many :birds, through: :rangemaps
end