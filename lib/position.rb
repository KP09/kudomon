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
    distance = Math.sqrt((x_delta ** 2) + (y_delta ** 2))
    distance <= NEARBY ? true : false
  end

  private

  def validate_position(coordinates)
    # We do allow coordinates to be nil if explicitly specified
    unless coordinates == nil

      if coordinates.class != Hash
        raise "Coordinates must be in hash format"
      end

      if coordinates[:x] == nil || coordinates[:y] == nil
        raise "Coordinate(s) missing"
      end

      if coordinates[:x] < 0 || coordinates [:y] < 0
        raise "Coordinates cannot be negative"
      end

    end
  end
end
