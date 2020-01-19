class Bird < ActiveRecord::Base
	BIRD_TYPES = ["Gulls", "Terns and Skimmers", "Tropicbirds", "Shearwaters, Jaegers, Albatrosses, and Petrels", "Pelicans", "Cormorants, Gannets, Anhingas and Booby Birds", "Razorbills, Guillemots, Auklets and Murres", "Loons and Grebes", 
		"Ducks, Geese and Swans", "Coots, Moorhens and Gallinules", "Rails", "Snipe and Woodcock", "Sandpipers and Other Shorebirds", "Herons, Egrets and Bitterns", "Ibises, Spoonbill and Avocet", "Flamingos", "Storks and Cranes", "Vultures", "Hawks, Kites and Eagles", "Caracaras", "Falcons", "Parrots",
		"Kingfishers", "Woodpeckers", "Flycatchers (Including Kingbirds)", "Crows, Ravens, Jays and Magpies", "Mockingbirds, Catbirds and Thrashers", "Shrikes", "Grackles, Blackbirds, Cowbirds and Starlings", "Orioles", "Waxwings", "Cardinals, Buntings, Grosbeaks and Tanagers", 
		"Sparrows, Juncos and Towhees", "Finches (Including Siskins)", "Titmice, Chickadees and Kinglets", "Nuthatches and Brown Creeper", "Wrens and Gnatcatchers", "Bushtit", "Warblers", "Vireos", "Trogons", "Hummingbirds", "Swifts", "Swallows and Martins", 
		"Thrushes (Including Bluebirds)", "Pipits", "Larks and Longspurs", "Pigeons and Doves", "Grouse, Partridge, Pheasants and Quail", "Chachalaca", "Turkeys", "Cuckoos", "Owls",  "Nightjars"] 
	has_many :sightings
	has_many :checklists, through: :sightings
	has_many :rangemaps
	has_many :regions, through: :rangemaps
	has_many :locations, through: :regions
end