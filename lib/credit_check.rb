# This class handles a fake credit check for the player
class CreditCheck
  def self.run
    print `clear`
    puts credit_kudos_ascii
    puts 'Performing Credit Kudos credit check'
    puts 'Analyzing income'
    loading
    puts "\n Analyzing expenses"
    loading
    print `clear`
    puts credit_kudos_ascii
    puts random_credit_message
  end

  def self.credit_kudos_ascii
    "   ____ ____  _____ ____ ___ _____   _  ___   _ ____   ___  ____
  / ___|  _ \\| ____|  _ \\_ _|_   _| | |/ / | | |  _ \\ / _ \\/ ___|
 | |   | |_) |  _| | | | | |  | |   | ' /| | | | | | | | | \\___ \\
 | |___|  _ <| |___| |_| | |  | |   | . \\| |_| | |_| | |_| |___) |
  \\____|_| \\_\\_____|____/___| |_|   |_|\\_\\\\___/|____/ \\___/|____/ "
  end

  def self.loading
    rand(3..9).times do
      print '.'
      sleep(0.5)
    end
  end

  def self.random_credit_message
    random_credit_score = rand(2)
    case random_credit_score
    when 0 then "Eeeeshk! You probably shouldn't be taking a loan out right now"
    when 1 then 'Good stuff! Looks like you can afford a loan no problem'
    when 2 then "Wowzer! You can splash the cash, you don't even need a loan!"
    end
  end
end
