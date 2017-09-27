class Trainer < Position
  attr_reader :name
  attr_accessor :collection

  def initialize(name, coordinates)
    super(coordinates)
    @name = name
    @collection = []
  end

  # Shows the nearby Kudomon to the trainer and returns them in an array
  def nearby_kudomon
    Kudomon.uncaught.select { |kudomon| kudomon.nearby?(self.coordinates) }
  end

  def move(y_shift, x_shift)
    self.coordinates[:y] += y_shift
    self.coordinates[:x] += x_shift
  end

  def catch(target_species)
    catchable_kudomon = self.nearby_kudomon
    nearby_species = catchable_kudomon.map { |kudomon| kudomon.species }
    if nearby_species.include?(target_species.capitalize)
      catch = Kudomon.new(target_species, nil)
      @collection << catch
      return true
    else
      return false
    end
  end
end
