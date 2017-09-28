# Require all necessary files from the index
require_relative 'index'

# KUDOMON GO
class App
  def initialize
    player_name = ask("What's your name?")
    @grid = Grid.new(player_name)
    @trainer = @grid.trainer
    @running = true
  end

  def run
    print `clear`
    puts "Hello #{@trainer.name} and Welcome to KUDOMON GO!"
    while @running
      # Display the grid size and Trainer's position
      @grid.display_grid_size
      @trainer.display_position

      # Determine the catchable kudomon nearby the trainer
      catchable_kudomon = @trainer.catchable_kudomon

      # Determine and display nearby challengeable Trainers
      challengeable_trainers = @trainer.challengeable_trainers

      # Show nearby kudomon message and nearby trainers
      show_catchable_kudomon(catchable_kudomon)
      show_challengeable_trainers(challengeable_trainers)

      # Determine whether the catch feature should be enabled this turn
      catch_enabled = catchable_kudomon.any?

      # Determine whether the challenge feature should be enabled this turn
      challenge_enabled = challengeable_trainers.any? && \
                          @trainer.live_kudomon?

      # Get an action from the Trainer and route accordingly
      action = get_trainer_action(catch_enabled, challenge_enabled)
      route(action, catch_enabled, challenge_enabled)
    end
    print `clear`
    puts "Ciao for now #{@trainer.name}! Play again soon!"
  end

  private

  def ask(question)
    print `clear`
    puts question
    gets.chomp
  end

  def show_catchable_kudomon(catchable_kudomon)
    puts '-' * 20
    if catchable_kudomon.any?
      puts "There are Kudomon nearby that you don't have yet!"
      catchable_kudomon.each do |k|
        puts "- #{k.species.upcase} (#{k.type}) HP: #{k.hp} // CP: #{k.cp}"
      end
    elsif @trainer.collection.length == KUDOMON.length
      puts 'Well done! You have caught all Kudomon species!'
    else
      puts 'No Kudomon nearby'
    end
  end

  def show_challengeable_trainers(challengeable_trainers)
    puts '-' * 20
    if challengeable_trainers.any?
      puts 'There are other Trainers nearby!'
      challengeable_trainers.each do |trainer|
        puts "- #{trainer.name.upcase}"
      end
    else
      puts 'No other Trainers nearby'
    end
  end

  def get_trainer_action(catch_enabled, challenge_enabled)
    puts '--------------------'
    puts 'Your options:'
    puts 'C - Catch some Kudomon' if catch_enabled
    puts 'F - Challenge another trainer' if challenge_enabled
    puts 'S - Check out your Kudomon Squad'
    puts 'M - Move around'
    puts 'R - Request credit check'
    puts 'Q - Quit the game'
    puts '\n'
    gets.chomp
  end

  # Router
  def route(action, catch_enabled, challenge_enabled)
    case action.upcase
    when 'C' then catch if catch_enabled
    when 'F' then challenge if challenge_enabled
    when 'S' then @trainer.show_squad
    when 'M' then move_trainer
    when 'R' then CreditCheck.run
    when 'Q' then end_game
    end
  end

  def catch
    puts 'Type the species of the Kudomon you want to catch'
    @trainer.catch(gets.chomp.capitalize)
  end

  def challenge
    # Find the Trainer to be challenged
    puts 'Type the name of the Trainer you want to challenge'
    target_name = gets.chomp.capitalize
    target_trainer = @trainer.challengeable_trainers.find do |trainer|
      trainer.name == target_name
    end

    # Find the Kudomon to be challenged with
    @trainer.show_squad
    puts "Type which Kudomon you want to challenge #{target_name} with"
    chosen_species = gets.chomp.capitalize
    chosen_kudomon = @trainer.collection.find do |kudomon|
      kudomon.species == chosen_species
    end

    return unless target_trainer && chosen_kudomon
    battle = Battle.new(@trainer, target_trainer, chosen_kudomon)
    battle.run
  end

  def move_trainer
    desired_shift = @trainer.desired_position_change
    if @grid.movement_valid?(@trainer.coordinates, desired_shift)
      @trainer.move(desired_shift)
      print `clear`
      puts 'Your position has been updated'
    else
      print `clear`
      puts "Sorry, that's beyond the grid"
    end
  end

  def end_game
    @running = false
  end
end

App.new.run if $PROGRAM_NAME == __FILE__
