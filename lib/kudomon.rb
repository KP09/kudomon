class Kudomon < Position
  attr_reader :species
  attr_reader :type
  attr_reader :position

  @@instance_collector = []

  def initialize(species, position)
    raise 'Undefined Kudomon' unless KUDOMON.include?(species.capitalize)
    super(position)
    @species = species.capitalize
    @type = KUDOMON[species.capitalize]
    @@instance_collector << self
  end

  def self.uncaught
    @@instance_collector.reject { |kudomon| kudomon.coordinates == nil }
  end

  def nearby?(coordinates)
    x_delta = self.coordinates[:x] - coordinates[:x]
    y_delta = self.coordinates[:y] - coordinates[:y]
    distance = Math.sqrt((x_delta ** 2) + (y_delta ** 2))
    distance <= NEARBY ? true : false
  end
end
