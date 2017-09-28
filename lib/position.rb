# This class stores coordinates and is used to inherit from
class Position
  attr_accessor :coordinates

  def initialize(coordinates)
    validate_position(coordinates)
    @coordinates = coordinates
  end

  # Returns true if a Position is nearby specified coordinates, false if not
  # see 'config.rb' for NEARBY
  def nearby?(coordinates)
    x_delta = self.coordinates[:x] - coordinates[:x]
    y_delta = self.coordinates[:y] - coordinates[:y]
    distance = Math.sqrt((x_delta**2) + (y_delta**2))
    distance <= NEARBY
  end

  private

  def validate_position(coordinates)
    # We do allow coordinates to be nil if explicitly specified
    return if coordinates.nil?
    raise 'Coordinates must be in hash format' if coordinates.class != Hash
    raise 'Coordinate(s) missing' if coordinates[:x].nil? || coordinates[:y].nil?
    raise 'Coordinates cannot be negative' if coordinates[:x] < 0 || coordinates [:y] < 0
  end
end
