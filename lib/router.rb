class Router
  def initialize
    @grid = Grid.new
    @trainer = @grid.trainer
    @running = true
  end

  def run
    puts "Hello #{@trainer.name} and Welcome to KUDOMON GO!"
    while @running
      display_trainer_position
      action = get_trainer_action
      route(action)
      print `clear`
    end
    puts "Farewell!"
  end

  private

  def display_trainer_position
    puts "The grid is #{GRID_SIZE} x #{GRID_SIZE}"
    puts "You are at:"
    puts "forward/back #{@trainer.position[:y]}"
    puts "left/right #{@trainer.position[:x]}"
  end

  def get_trainer_action
    puts "-----------------"
    puts "Your options:"
    puts "1 - Move around"
    puts "9 - Quit the game"
    gets.chomp.to_i
  end

  def route(action)
    case action
    when 1 then @grid.move_trainer
    when 9 then end_game
    end
  end

  def end_game
    @running = false
  end
end
