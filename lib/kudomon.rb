class Kudomon < Position
  def initialize(species, position)
    raise 'Undefined Kudomon' unless KUDOMON.include?(species)
    super(position)
    @species = species
    @type = KUDOMON[species]
  end
end
