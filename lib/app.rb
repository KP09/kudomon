# Require all necessary files from the index
require_relative 'index'

# Initialize a router based on the controller
router = Router.new

# Start the app
router.run
