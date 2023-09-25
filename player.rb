class Player
  attr_reader :name, :lives

  def initialize(name, lives = 3)
    @name = name
    @lives = lives
  end

  def remove_life
    @lives -= 1
  end
end