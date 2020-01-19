bird_types = {"Gulls" => ["gull", "kittiwake"], "Ducks, Geese and Swans" => ["duck", "teal", "wigeon", "Bufflehead", "merganser", "Redhead", "eider", "scaup", "scoter", "Mallard", "goose", "Brant", "pintail", "goldeneye", "Canvasback", "swan"], "Warblers" => ["warbler", "ovenbird", "redstart", "yellowthroat", "chat"],
"Parrots" => ["parrot", "parakeet", "amazon", "macaw"], "Hummingbirds" => ["hummingbird"], "Swallows and Martins" => ["swallow", "martin"], "Swifts" => ["swift"], "Falcons" => ["falcon", "kestrel", "Merlin"], "Caracaras" => ["caracara"], "Tropicbirds" => ["tropicbird"],
"Terns and Skimmers" => ["tern", "skimmer"], "Owls" => ["owl"], "Vireos" => ["vireo"], "Hawks, Kites and Eagles" => ["hawk", "kite", "eagle", "Osprey", "harrier"],
"Nightjars" => ["whip-poor-will", "Chuck-will's-widow", "nighthawk", "poorwill"], "Sandpipers and Other Shorebirds" => ["sandpiper", "plover", "Killdeer", "Willet", "curlew", "yellowlegs", "phalarope", "tattler", "oystercatcher", "dowitcher", "godwit", "turnstone", "knot", "Dunlin"], "Snipe and Woodcock" => ["snipe", "woodcock"], 
"Crows, Ravens, Jays and Magpies" => ["crow", "raven", "jay", "magpie"], "Grackles, Blackbirds, Cowbirds and Starlings" => ["grackle", "blackbird", "cowbird", "starling"], "Pipits" => ["pipit"], "Herons, Egrets and Bitterns" => ["heron", "egret", "bittern"], "Ibises, Spoonbill and Avocet" => ["ibis", "Limpkin", "spoonbill", "avocet", "stilt"], "Storks and Cranes" => ["stork", "crane"], "Vultures" => ["vulture"], "Kingfishers" => ["kingfisher"],
"Titmice, Chickadees and Kinglets" => ["chickadee", "kinglet", "titmouse", "Verdin"], "Bushtit" => ["bushtit"], "Wrens and Gnatcatchers" => ["wren", "gnatcatcher"], "Flycatchers (Including Kingbirds and Becards)" => ["flycatcher", "kingbird", "phoebe", "pewee","kiskadee", "becard", "tyrannulet"],
"Thrushes (Including Bluebirds)" => ["bluebird", "robin", "thrush"], "Larks and Longspurs" => ["lark", "longspur", "Snow bunting"],"Woodpeckers" => ["woodpecker", "flicker"], "Flamingos" => ["flamingo"], "Nuthatches and Brown Creeper" => ["nuthatch", "creeper"], "Loons and Grebes" => ["loon", "grebe"], "Shearwaters, Jaegers, Albatrosses, and Petrels" => ["shearwater", "fulmar", "jaeger", "skua", "albatross", "petrel", "storm-petrel"],
"Cormorants, Gannets, Anhingas and Booby Birds" => ["cormorant", "anhinga", "gannet", "booby"], "Pelicans" => ["pelican"],
"Cardinals, Buntings, Grosbeaks and Tanagers" => ["cardinal", "grosbeak", "bunting", "tanager", "Bobolink", "Dickcissel"], "Waxwings" => ["waxwing"], "Finches (Including Siskins and Crossbills)" => ["finch", "siskin", "crossbill"], "Mockingbirds, Catbirds and Thrashers" => ["mockingbird", "catbird", "thrasher"], "Razorbills, Guillemots, Auklets and Murres" => ["auklet", "guillemot", "murrelet", "puffin", "murre", "Dovekie", "gannet", "Razorbill"], "Sparrows, Juncos and Towhees" => ["sparrow", "junco", "towhee"],
"Pigeons and Doves" => ["pigeon", "dove"], "Trogons" => ["trogon"], "Cuckoos" => ["cuckoo", "roadrunner"], "Orioles" => ["oriole"], "Shrikes" => ["shrike"], "Grouse, Partridge, Pheasants and Quail" => ["grouse", "partridge", "Chukar", "ptarmigan", "pheasant", "chicken", "quail", "bobwhite"], "Chachalaca" => ["chachalaca"], "Turkeys" => ["turkey"],
"Coots, Moorhens and Gallinules" => ["coot", "moorhen", "gallinule"], "Rails" => ["Sora", "rail"]} 

bird_types.each do |group, genuses|
	genuses.each do |genus|
		species = Bird.all.select{|bird| bird.common_name.match(/\b#{genus}\b/)}
		species.each do |specie|
			specie.grouping = group
			specie.save
		end
	end
end
