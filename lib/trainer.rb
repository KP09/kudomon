# This class creates Trainers
class Trainer < Position
  attr_reader :name
  attr_accessor :collection

  @@instance_collector = []

  def self.all
    @@instance_collector
  end

  def initialize(name, coordinates)
    super(coordinates)
    @name = name
    @collection = []
    @@instance_collector << self
  end

  def display_position
    puts 'Your current position:'
    puts "#{coordinates[:y]} forward/back"
    puts "#{coordinates[:x]} left/right"
  end

  def desired_position_change
    print `clear`
    display_position
    puts '\n'
    shift = {}
    puts 'How far forward or back do you want to move? (Fwd: + / Back: -)'
    shift[:y] = gets.chomp.to_i
    puts 'How far left or right do you want to move? (Right: + / Left: -)'
    shift[:x] = gets.chomp.to_i
    shift
  end

  # Returns true if a trainer has one or more kudomon with positive HP
  def live_kudomon?
    return true if collection.any? { |kudomon| kudomon.hp > 0 }
  end

  # Shows all of a Trainer's Kudomon
  def show_squad
    if collection.any?
      message('Your Kudomon Squad:')
      collection.each do |k|
        puts "- #{k.species.upcase} (#{k.type}) HP: #{k.hp} // CP: #{k.cp}"
      end
    else
      message("You haven't caught any Kudomon yet")
    end
  end

  # Returns Kudomon that are nearby the Trainer as set in 'config.rb'
  # and that the Trainer does not have yet
  def catchable_kudomon
    free_kudomon = Kudomon.free.select { |k| k.nearby?(coordinates) }
    free_kudomon.reject { |k| already_has?(k.species) }
  end

  # Return Trainers that are nearby and have live kudomon
  def challengeable_trainers
    other_trainers = Trainer.all.reject { |trainer| trainer == self }
    other_trainers.select do |trainer|
      trainer.nearby?(coordinates) && trainer.live_kudomon?
    end
  end

  # Moves the trainer by the specified amounts
  def move(shift)
    coordinates[:y] += shift[:y]
    coordinates[:x] += shift[:x]
  end

  # Returns true if a trainer already has the species, false if not
  def already_has?(species)
    species_collection = collection.map(&:species)
    species_collection.include?(species.capitalize)
  end

  # Catches a targeted species if that species is nearby
  def catch(target_species)
    nearby_species = catchable_kudomon.map(&:species)

    # If the target species is nearby, create a new Kudomon of that species
    # and add it to the Trainer's collection
    if nearby_species.include?(target_species)
      catch = Kudomon.new(target_species, nil)
      @collection << catch
      message("You've succesfully caught #{target_species.upcase}")
    else
      message('Sorry, thats not a valid choice')
    end
  end

  private

  def message(message)
    print `clear`
    puts message
  end
end
