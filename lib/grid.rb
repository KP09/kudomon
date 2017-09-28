# This class is the grid on which KUDOMON go is played
class Grid
  attr_reader :trainer

  # Initializes a trainer and spawns Kudomon
  def initialize(player_name)
    @trainer = Trainer.new(player_name.capitalize, random_position)
    spawn_kudomon
    spawn_trainers
  end

  def display_grid_size
    puts "\n" + "*" * 20
    puts "The grid is #{GRID_SIZE} x #{GRID_SIZE}"
  end

  # Validates desired trainer movements
  def movement_valid?(coordinates, desired_shift)
    proposed_y_position = coordinates[:y] + desired_shift[:y]
    proposed_x_position = coordinates[:x] + desired_shift[:x]

    if proposed_y_position > GRID_SIZE \
        || proposed_x_position > GRID_SIZE \
        || proposed_y_position < 0 \
        || proposed_x_position < 0
      return false
    else
      return true
    end
  end

  private

  def random_position
    { x: rand(GRID_SIZE), y: rand(GRID_SIZE) }
  end

  # Spawns the number of Kudomon as specified in config.rb
  def spawn_kudomon
    NUMBER_OF_KUDOMON.times do
      Kudomon.new(KUDOMON.keys.sample, random_position)
    end
  end

  # Spawns computer Trainers in random positions
  # Gives them all a random number of Kudomon
  def spawn_trainers
    COMPUTER_NAMES.each do |name|
      new_trainer = Trainer.new(name, random_position)
      rand(1..KUDOMON.length).times do
        new_kudomon = Kudomon.new(KUDOMON.keys.sample, nil)
        new_trainer.collection << new_kudomon
      end
    end
  end
end
