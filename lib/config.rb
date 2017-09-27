# Set the size of the grid (squared)
GRID_SIZE = 50

# Set how many Kudomon to spawn inside the grid
NUMBER_OF_KUDOMON = 25

# Set the definition of 'nearby'
NEARBY = 10

# Set the Kudomon for the game
KUDOMON = {
  'Sourbulb' => :grass,
  'Mancharred' => :fire,
  'Chikapu' => :electric,
  'Artikudo' => :rock,
  'Charchomp' => :psychic,
  'Kudoise' => :water
}.freeze

# Set the possible names of computer Trainers
COMPUTER_NAMES = %w[
  Brendan
  Lucas
  Hilbert
  Nate
  Calem
  Sun
  Serena
  Rosa
  Dawn
  Lyra
].freeze
