# Require all necessary files from the index
require_relative 'index'

class App
  def initialize
    trainer_name = ask("What's your name?")
    @grid = Grid.new(trainer_name)
    @trainer = @grid.trainer
    @running = true
  end

  def run
    puts "Hello #{@trainer.name.capitalize} and Welcome to KUDOMON GO!"
    while @running
      display_trainer_position
      nearby_kudomon = @trainer.nearby_kudomon
      show_nearby_kudomon(nearby_kudomon)
      action = get_trainer_action(nearby_kudomon.any?)
      route(action, nearby_kudomon.any?)
    end
    puts "Farewell!"
  end

  private

  # Asks a player for their name
  def ask(question)
    puts question
    gets.chomp
  end

  def display_trainer_position
    puts "\n \n \n"
    puts "********************"
    puts "The grid is #{GRID_SIZE} x #{GRID_SIZE}"
    puts "You are at:"
    puts "#{@trainer.position[:y]} forward/back "
    puts "#{@trainer.position[:x]} left/right"
  end

  def get_trainer_action(catch_enabled)
    puts "--------------------"
    puts "Your options:"
    puts "C - Catch some Kudomon" if catch_enabled
    puts "S - Check out your Kudomon Squad"
    puts "M - Move around"
    puts "Q - Quit the game"
    gets.chomp
  end

  def show_nearby_kudomon(nearby_kudomon)
    puts "--------------------"
    if nearby_kudomon.any?
      puts "There are Kudomon nearby"
      nearby_kudomon.each do |kudomon|
        puts "#{kudomon.species.upcase} (#{kudomon.type})"
      end
    else
      puts "No Kudomon nearby"
    end
  end

  def route(action, catch_enabled)
    case action.upcase
    when "C" then @trainer.catch_kudomon if catch_enabled
    when "S" then @trainer.show_squad
    when "M" then @grid.move_trainer
    when "Q" then end_game
    end
  end

  def end_game
    @running = false
  end
end

if __FILE__ == $PROGRAM_NAME
  App.new.run
end
