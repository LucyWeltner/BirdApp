require './config/environment'

use Rack::MethodOverride

Rack::MethodOverride

use BirdController
use BirderController
use ChecklistController
use LocationController
run ApplicationController 

