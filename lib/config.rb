# Set the size of the grid (squared)
GRID_SIZE = 50

# Set how many Kudomon to spawn inside the grid
NUMBER_OF_KUDOMON = 25

# Set the definition of 'nearby'
NEARBY = 10

# Set the Kudomon for the game
# make sure the species are capitalized
KUDOMON = {
  'Sourbulb' => {type: :grass, hp: 100, cp: 20},
  'Mancharred' => {type: :fire, hp: 110, cp: 12},
  'Chikapu' => {type: :electric, hp: 70, cp: 13},
  'Artikudo' => {type: :rock, hp: 90, cp: 15},
  'Charchomp' => {type: :psychic, hp: 80, cp: 10},
  'Kudoise' => {type: :water, hp: 120, cp: 30}
}.freeze

# Set the number of and possible names of computer Trainers
# make sure the names are capitalized
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

# Set the random multiplier for regular damage infliction
RANDOM_MULTIPLIER = rand(0.5..1)

# Set what types are Super Effective against other types
SUPER_EFFECTIVE = {
  water: :fire,
  fire: :grass,
  grass: :rock,
  rock: :electric,
  electric: :water
}

# Set the impact of super effectiveness on damage infliction
SUPER_EFFECTIVE_MULTIPLIER = 2

# Set the type that is mega effective against all other types, except itself
MEGA_EFFECTIVE = :psychic

# Set the impact of mega effectivenesss on damage infliction
MEGA_EFFECTIVE_MULTIPLIER = 3
