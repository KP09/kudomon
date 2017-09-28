# This class handles battles between Trainers and their Kudomon
class Battle
  attr_reader :challenger
  attr_reader :defender
  attr_reader :challenger_kudomon
  attr_reader :defender_kudomon
  attr_reader :trainers

  def initialize(challenger, defender, chosen_kudomon)
    @challenger = challenger
    @defender = defender
    @challenger_kudomon = chosen_kudomon
    # Randomly pick one of the defender's Kudomon
    @defender_kudomon = @defender.collection.sample
    # Shuffle to randomize who starts
    @trainers = [@challenger, @defender].shuffle
  end

  def run
    battle_start_message(@trainers.first, @trainers.last)

    # Short pause for better user experience
    sleep(0.5)

    until (@challenger_kudomon.hp <= 0) || (@defender_kudomon.hp <= 0)
      # Set which Trainer is attacking/defending
      att_trainer = @trainers.first
      def_trainer = @trainers.last

      # Set which Kudomon is attacking/defending
      att_kudomon = find_kudomon(att_trainer)
      def_kudomon = find_kudomon(def_trainer)

      damage = calculate_damage(att_kudomon, def_kudomon)
      inflict_damage(def_kudomon, damage)
      damage_message(att_trainer, att_kudomon, def_trainer, def_kudomon, damage)
      alternate_turn

      # Short pause for better user experience
      sleep(2)
    end

    winning_pair = determine_winning_pair
    battle_end_message(winning_pair)

    # Return the winning pair for testing
    winning_pair
  end

  private

  def battle_start_message(first_tr, second_tr)
    # Works out the starting state of the game
    first_kudo = find_kudomon(first_tr)
    second_kudo = find_kudomon(second_tr)

    print `clear`
    puts 'LET THE BATTLE BEGIN!'
    puts "#{first_tr.name}'s #{first_kudo.species} (#{first_kudo.type})"
    puts '---------- VS ----------'
    puts "#{second_tr.name}'s #{second_kudo.species} (#{second_kudo.type})"
    puts '\n'
  end

  # Returns the challenger_kudomon if given the challenging Trainer
  # and the defender_kudomon if given the defending Trainer
  def find_kudomon(trainer)
    trainer == @challenger ? @challenger_kudomon : @defender_kudomon
  end

  # Calculates the damage an attacker will inflict on a defender
  # See 'config.rb'
  def calculate_damage(att_kudomon, def_kudomon)
    if att_kudomon.type == MEGA_EFFECTIVE && def_kudomon.type != MEGA_EFFECTIVE
      att_kudomon.cp * MEGA_EFFECTIVE_MULTIPLIER
    elsif SUPER_EFFECTIVE[att_kudomon.type] == def_kudomon.type
      att_kudomon.cp * SUPER_EFFECTIVE_MULTIPLIER
    else
      att_kudomon.cp
    end
  end

  def inflict_damage(def_kudomon, damage)
    def_kudomon.hp -= damage
  end

  def damage_message(att_tr, att_kudo, def_tr, def_kudo, damage)
    puts "#{att_tr.name}'s #{att_kudo.species} inflicts #{damage} damage"
    puts "#{def_tr.name}'s #{def_kudo.species} has #{def_kudo.hp} HP remaining"
    puts "\n"
  end

  def alternate_turn
    @trainers.reverse!
  end

  def determine_winning_pair
    if @challenger_kudomon.hp > @defender_kudomon.hp
      { trainer: @challenger, kudomon: @challenger_kudomon }
    else
      { trainer: @defender, kudomon: @defender_kudomon }
    end
  end

  def battle_end_message(winners)
    print `clear`
    puts "IT'S ALL OVER!"
    puts "#{winners[:trainer].name}'s #{winners[:kudomon].species} wins"
  end
end
