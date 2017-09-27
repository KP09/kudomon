class Kudomon < Position
  attr_reader :species
  attr_reader :type
  attr_reader :position
  attr_reader :cp
  attr_accessor :hp

  @@instance_collector = []

  def initialize(species, position)
    raise 'Undefined Kudomon' unless KUDOMON.include?(species.capitalize)
    super(position)
    @species = species.capitalize
    @type = KUDOMON[@species][:type]
    @hp = KUDOMON[@species][:hp]
    @cp = KUDOMON[@species][:cp]
    @@instance_collector << self
  end

  # Returns all Kudomon instances that are free
  def self.free
    @@instance_collector.reject { |kudomon| kudomon.coordinates == nil }
  end
end
