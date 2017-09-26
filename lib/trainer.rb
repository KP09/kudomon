class Trainer < Position
  attr_reader :name

  def initialize(name, position)
    super(position)
    @name = name
  end
end
