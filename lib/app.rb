# Require all necessary files from the index
require_relative 'index'

class App
  def initialize
    @grid = Grid.new("Kees")
    @trainer = @grid.trainer
    @running = true
  end

  def run
    message("Hello and Welcome to KUDOMON GO!")
    while @running
      # Display the grid size and Trainer's position
      display_grid_size
      display_trainer_position

      # Determine and display catchable Kudomon
      catchable_kudomon = @trainer.nearby_kudomon
      show_nearby_kudomon(catchable_kudomon)

      # Get an action from the Trainer and route accordingly
      # 'Nearby_kudomon.any?' is to enable/disable menu for catching Kudomon
      action = get_trainer_action(catchable_kudomon.any?)
      route(action, catchable_kudomon)
    end
    message("Farewell")
  end

  private

  # ROUTES
  def route(action, catchable_kudomon)
    case action.upcase
    when "C" then catch if catchable_kudomon.any?
    when "S" then show_squad
    when "M" then move_trainer
    when "R" then credit_check
    when "Q" then end_game
    end
  end

  # CONTROLLER METHODS
  def catch
    puts "Type the species of the Kudomon you want to catch"
    target_species = gets.chomp.capitalize

    if @trainer.catch(target_species)
      message("You've succesfully caught #{target_species.upcase}")
    else
      message("Sorry, thats not a valid choice")
    end
  end

  def show_squad
    squad = @trainer.collection
    if squad.any?
      message("Your Kudomon Squad:")
      squad.each do |kudomon|
        puts "- #{kudomon.species.upcase} (#{kudomon.type})"
      end
    else
      message("You haven't caught any Kudomon yet")
    end
  end

  def move_trainer
    shift = desired_position_change
    if @grid.move_trainer(shift[:y], shift[:x])
      message("Your position has been updated")
    else
      message("Sorry, that's beyond the grid")
    end
  end

  def credit_check
    print `clear`
    puts "   ____ ____  _____ ____ ___ _____   _  ___   _ ____   ___  ____
  / ___|  _ \\| ____|  _ \\_ _|_   _| | |/ / | | |  _ \\ / _ \\/ ___|
 | |   | |_) |  _| | | | | |  | |   | ' /| | | | | | | | | \\___ \\
 | |___|  _ <| |___| |_| | |  | |   | . \\| |_| | |_| | |_| |___) |
  \\____|_| \\_\\_____|____/___| |_|   |_|\\_\\\\___/|____/ \\___/|____/
"
    puts "Performing Credit Kudos credit check"
    puts "Analyzing income"
    loading
    puts "\n Analyzing expenses"
    loading
    puts "\n" + random_credit_message
  end

  def loading
    rand(3..9).times do
      print '.'
      sleep(0.5)
    end
  end

  def random_credit_message
    random_credit_score = rand(2)
    case random_credit_score
      when 0 then "Eeeeshk, you probably shouldn't be taking a loan out right now"
      when 1 then "Cool, you can afford a loan no problem"
      when 2 then "Wowzer! You can splash the cash, you don't even need a loan!"
    end
  end

  def end_game
    @running = false
  end

  # VIEWS
  def ask(question)
    print `clear`
    puts question
    gets.chomp
  end

  def message(message)
    print `clear`
    puts message
  end

  def desired_position_change
    print `clear`
    display_trainer_position
    puts "\n"
    shift = {}
    puts "How far forward or back do you want to move? (Fwd: + / Back: -)"
    shift[:y] = gets.chomp.to_i
    puts "How far left or right do you want to move? (Right: + / Left: -)"
    shift[:x] = gets.chomp.to_i
    shift
  end

  def display_grid_size
    puts "\n"
    puts "********************"
    puts "The grid is #{GRID_SIZE} x #{GRID_SIZE}"
  end

  def display_trainer_position
    puts "Your current position:"
    puts "#{@trainer.coordinates[:y]} forward/back "
    puts "#{@trainer.coordinates[:x]} left/right"
  end

  def show_nearby_kudomon(catchable_kudomon)
    puts "--------------------"
    if catchable_kudomon.any?
      puts "There are Kudomon nearby!"
      catchable_kudomon.each do |kudomon|
        puts "#{kudomon.species.upcase} (#{kudomon.type})"
      end
    else
      puts "No Kudomon nearby"
    end
  end

  def get_trainer_action(catch_enabled)
    puts "--------------------"
    puts "Your options:"
    puts "C - Catch some Kudomon" if catch_enabled
    puts "S - Check out your Kudomon Squad"
    puts "M - Move around"
    puts "R - Request credit check"
    puts "Q - Quit the game"
    puts "\n"
    gets.chomp
  end
end

if __FILE__ == $PROGRAM_NAME
  App.new.run
end
