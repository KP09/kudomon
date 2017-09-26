class Kudomon < Position
  attr_reader :species
  attr_reader :type
  attr_reader :position

  def initialize(species, position)
    raise 'Undefined Kudomon' unless KUDOMON.include?(species.capitalize)
    super(position)
    @species = species.capitalize
    @type = KUDOMON[species.capitalize]
  end

  def nearby?(position)
    x_delta = self.position[:x] - position[:x]
    y_delta = self.position[:y] - position[:y]
    distance = Math.sqrt((x_delta ** 2) + (y_delta ** 2))
    distance <= NEARBY ? true : false
  end
end
