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

      # Determine the catchable kudomon nearby the trainer
      catchable_kudomon = @trainer.catchable_kudomon

      # Determine and display nearby challengeable Trainers
      challengeable_trainers = @trainer.challengeable_trainers

      # Show nearby kudomon message and nearby tr
      show_catchable_kudomon(catchable_kudomon)
      show_challengeable_trainers(challengeable_trainers)

      # Determine whether the catch feature should be enabled this turn
      catch_enabled = catchable_kudomon.any?

      # Determine whether the challenge feature should be enabled this turn
      challenge_enabled = challengeable_trainers.any? && @trainer.has_live_kudomon?

      # Get an action from the Trainer and route accordingly
      action = get_trainer_action(catch_enabled, challenge_enabled)
      route(action, catch_enabled, challenge_enabled)
    end
    message("Farewell")
  end

  private

  # Helpers

  def ask(question)
    print `clear`
    puts question
    gets.chomp
  end

  def message(message)
    print `clear`
    puts message
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

  def show_catchable_kudomon(catchable_kudomon)
    puts "--------------------"
    if catchable_kudomon.any?
      puts "There are Kudomon nearby that you don't have yet!"
      catchable_kudomon.each do |kudomon|
        puts "- #{kudomon.species.upcase} (#{kudomon.type}) HP: #{kudomon.hp} // CP: #{kudomon.cp}"
      end
    elsif @trainer.collection.length == KUDOMON.length
      puts "Well done! You have caught all Kudomon species!"
    else
      puts "No Kudomon nearby"
    end
  end

  def show_challengeable_trainers(challengeable_trainers)
    puts "--------------------"
    if challengeable_trainers.any?
      puts "There are other Trainers nearby!"
      challengeable_trainers.each do |trainer|
        puts "- #{trainer.name.upcase}"
      end
    else
      puts "No other Trainers nearby"
    end
  end

  def get_trainer_action(catch_enabled, challenge_enabled)
    puts "--------------------"
    puts "Your options:"
    puts "C - Catch some Kudomon" if catch_enabled
    puts "F - Challenge another trainer" if challenge_enabled
    puts "S - Check out your Kudomon Squad"
    puts "M - Move around"
    puts "R - Request credit check"
    puts "Q - Quit the game"
    puts "\n"
    gets.chomp
  end

  # Router
  def route(action, catch_enabled, challenge_enabled)
    case action.upcase
    when "C" then catch if catch_enabled
    when "F" then challenge if challenge_enabled
    when "S" then show_squad
    when "M" then move_trainer
    when "R" then credit_check
    when "Q" then end_game
    end
  end

  # Handles the catching of a Kudomon
  def catch
    puts "Type the species of the Kudomon you want to catch"
    target_species = gets.chomp.capitalize

    if @trainer.catch(target_species)
      message("You've succesfully caught #{target_species.upcase}")
    else
      message("Sorry, thats not a valid choice")
    end
  end

  # Handles the challenging of another Trainer
  def challenge
    # Find the Trainer to be challenged
    puts "Type the name of the Trainer you want to challenge"
    target_name = gets.chomp.capitalize
    target_trainer = @trainer.challengeable_trainers.find { |trainer| trainer.name == target_name }

    # Find the Kudomon to be challenged with
    show_squad
    puts "Type which Kudomon you want to challenge #{target_name} with"
    chosen_species = gets.chomp.capitalize
    chosen_kudomon = @trainer.collection.find { |kudomon| kudomon.species == chosen_species }

    # Determine if the trainer is a valid choice and run a new Battle if so
    if target_trainer && chosen_kudomon
      battle = Battle.new(@trainer, target_trainer, chosen_kudomon)
      battle.run
    end
  end

  # Handles the displaying of the player's Kudomon squad
  def show_squad
    squad = @trainer.collection
    if squad.any?
      message("Your Kudomon Squad:")
      squad.each do |kudomon|
        puts "- #{kudomon.species.upcase} (#{kudomon.type}) HP: #{kudomon.hp} // CP: #{kudomon.cp}"
      end
    else
      message("You haven't caught any Kudomon yet")
    end
  end

  # Handles moving the player around the Grid
  def move_trainer
    shift = desired_position_change
    if @grid.move_trainer(shift[:y], shift[:x])
      message("Your position has been updated")
    else
      message("Sorry, that's beyond the grid")
    end
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

  # Handles the ending of the game
  def end_game
    @running = false
  end

  # Handles fake-checking the player's creditworthiness
  def credit_check
    print `clear`
    puts credit_kudos_asci
    puts "Performing Credit Kudos credit check"
    puts "Analyzing income"
    loading
    puts "\n Analyzing expenses"
    loading
    print `clear`
    puts credit_kudos_asci
    puts random_credit_message
  end

  def credit_kudos_asci
    "   ____ ____  _____ ____ ___ _____   _  ___   _ ____   ___  ____
  / ___|  _ \\| ____|  _ \\_ _|_   _| | |/ / | | |  _ \\ / _ \\/ ___|
 | |   | |_) |  _| | | | | |  | |   | ' /| | | | | | | | | \\___ \\
 | |___|  _ <| |___| |_| | |  | |   | . \\| |_| | |_| | |_| |___) |
  \\____|_| \\_\\_____|____/___| |_|   |_|\\_\\\\___/|____/ \\___/|____/"
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
end

if __FILE__ == $PROGRAM_NAME
  App.new.run
end
