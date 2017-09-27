class Grid
  attr_reader :trainer

  # Initializes a trainer and spawns Kudomon
  def initialize(trainer_name)
    @trainer = Trainer.new(trainer_name, random_position)
    spawn_kudomon
    spawn_trainers
  end

  # Try to move the trainer and return true or false depending on success
  def move_trainer(y_shift, x_shift)
    if movement_valid?(y_shift, x_shift)
      @trainer.move(y_shift, x_shift)
      return true
    else
      return false
    end
  end

  private

  def random_position
    {x: rand(GRID_SIZE), y: rand(GRID_SIZE)}
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

  # Validates desired trainer movements
  def movement_valid?(y_shift, x_shift)
    proposed_y_position = @trainer.coordinates[:y] + y_shift
    proposed_x_position = @trainer.coordinates[:x] + x_shift

    if proposed_y_position > GRID_SIZE \
        || proposed_x_position > GRID_SIZE \
        || proposed_y_position < 0 \
        || proposed_x_position < 0
      return false
    else
      return true
    end
  end
end
