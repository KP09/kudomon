# This class is the grid on which KUDOMON go is played
class Grid
  attr_reader :trainer

  # Initializes a trainer and spawns Kudomon
  def initialize(player_name)
    @grid_size = GRID_SIZE
    @number_of_kudomon = NUMBER_OF_KUDOMON
    @kudomon = KUDOMON
    @computer_names = COMPUTER_NAMES
    @trainer = Trainer.new(player_name.capitalize, random_position)
    spawn_kudomon
    spawn_trainers
  end

  def display_grid_size
    puts "\n" + "*" * 20
    puts "The grid is #{@grid_size} x #{@grid_size}"
  end

  # Validates desired trainer movements
  def movement_valid?(coordinates, desired_shift)
    proposed_y_position = coordinates[:y] + desired_shift[:y]
    proposed_x_position = coordinates[:x] + desired_shift[:x]

    if proposed_y_position > @grid_size \
        || proposed_x_position > @grid_size \
        || proposed_y_position < 0 \
        || proposed_x_position < 0
      return false
    else
      return true
    end
  end

  private

  def random_position
    { x: rand(@grid_size), y: rand(@grid_size) }
  end

  # Spawns the number of Kudomon as specified in config.rb
  def spawn_kudomon
    @number_of_kudomon.times do
      Kudomon.new(@kudomon.keys.sample, random_position)
    end
  end

  # Spawns computer Trainers in random positions
  # Gives them all a random number of Kudomon
  def spawn_trainers
    @computer_names.each do |name|
      new_trainer = Trainer.new(name, random_position)
      rand(1..@kudomon.length).times do
        new_kudomon = Kudomon.new(@kudomon.keys.sample, nil)
        new_trainer.collection << new_kudomon
      end
    end
  end
end
