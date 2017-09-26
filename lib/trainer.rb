class Trainer < Position
  attr_reader :name

  def initialize(name, position)
    super(position)
    @name = name
    @collection = []
  end

  # Shows the nearby Kudomon to the trainer and returns them in an array
  def nearby_kudomon
    nearby_kudomon = []

    uncaught_kudomon = ObjectSpace.each_object(Kudomon).to_a
    uncaught_kudomon.reject! { |kudomon| kudomon.position == nil }

    uncaught_kudomon.each do |kudomon|
      nearby_kudomon << kudomon if kudomon.nearby?(self.position)
    end

    nearby_kudomon
  end

  def catch_kudomon
    puts "Which kudomon would you like to catch?"
    species = gets.chomp

    nearby_species = nearby_kudomon.map { |kudomon| kudomon.species }

    if nearby_species.include?(species.capitalize)
      catch = Kudomon.new(species, nil)
      @collection << catch
      puts "You've succesfully caught #{species.upcase}"
    else
      puts "Sorry, thats not a valid choice"
    end
  end

  def show_squad
    if @collection.any?
      puts "Your Kudomon Squad:"
      @collection.each do |kudomon|
        puts "- #{kudomon.species.upcase} (#{kudomon.type})"
      end
    else
      puts "You haven't caught any Kudomon yet"
    end
  end

  private

  def catch_valid?(kudomon)
    if KUDOMON.include?(kudomon)
    end
  end
end
