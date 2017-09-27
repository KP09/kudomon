class Trainer < Position
  attr_reader :name
  attr_accessor :collection

  @@instance_collector = []

  def initialize(name, coordinates)
    super(coordinates)
    @name = name
    @collection = []
    @@instance_collector << self
  end

  def self.all
    @@instance_collector
  end

  # Returns Kudomon that are nearby the trainer as set in 'config.rb'
  def catchable_kudomon
    free_kudomon = Kudomon.free.select { |kudomon| kudomon.nearby?(self.coordinates) }
    uncaught_kudomon = free_kudomon.reject { |kudomon| self.already_has?(kudomon.species) }
  end

  # Return Trainers that are nearby and have live kudomon
  def challengeable_trainers
    other_trainers = Trainer.all.reject { |trainer| trainer == self }
    other_trainers.select do |trainer|
      trainer.nearby?(self.coordinates) && trainer.has_live_kudomon?
    end
  end

  # Moves the trainer by the specified amounts
  def move(y_shift, x_shift)
    self.coordinates[:y] += y_shift
    self.coordinates[:x] += x_shift
  end

  # Returns true if a trainer already has the species, false if not
  def already_has?(species)
    species_collection = self.collection.map { |kudomon| kudomon.species }
    species_collection.include?(species.capitalize)
  end

  # Returns true if a trainer has kudomon with positive HP
  def has_live_kudomon?
    return true if self.collection.any? { |kudomon| kudomon.hp > 0 }
  end

  # Catches a targeted species
  # if that species is nearby and the trainer doesn't already have that species
  def catch(target_species)
    nearby_species = catchable_kudomon.map { |kudomon| kudomon.species }
    if nearby_species.include?(target_species.capitalize)
      unless self.already_has?(target_species)
        catch = Kudomon.new(target_species, nil)
        @collection << catch
        return true
      end
    else
      return false
    end
  end
end
