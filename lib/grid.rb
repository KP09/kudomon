class Grid
  attr_reader :trainer

  # Initializes a trainer and spawns Kudomon
  def initialize(trainer_name)
    @trainer = Trainer.new(trainer_name, random_position)
    spawn_kudomon
  end

  # Asks the trainer for desired movement and sends the answers for validation
  def move_trainer
    puts "How far forward or back do you want to move? (Fwd: + / Back: -)"
    desired_y_movement = gets.chomp.to_i

    puts "How far left or right do you want to move? (Right: + / Left: -)"
    desired_x_movement = gets.chomp.to_i

    validate_movement(desired_y_movement, desired_x_movement)
  end

  private

  # Finds a random position within the grid
  def random_position
    {x: rand(GRID_SIZE), y: rand(GRID_SIZE)}
  end

  # Spawns the number of Kudomon as specified in config.rb
  def spawn_kudomon
    NUMBER_OF_KUDOMON.times do
      Kudomon.new(KUDOMON.keys.sample, random_position)
    end
  end

  # Validates desired trainer movements and updates position if valid
  def validate_movement(desired_y_movement, desired_x_movement)
    proposed_y_position = @trainer.position[:y] + desired_y_movement
    proposed_x_position = @trainer.position[:x] + desired_x_movement

    if proposed_y_position > GRID_SIZE \
      || proposed_x_position > GRID_SIZE \
      || proposed_y_position < 0 \
      || proposed_x_position < 0
      puts "Sorry, that's beyond the grid"
      move_trainer
    else
      @trainer.position[:y] += desired_y_movement
      @trainer.position[:x] += desired_x_movement
    end
  end
end
