class Rangemap < ActiveRecord::Base
	belongs_to :region
	belongs_to :bird
end