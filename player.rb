class Player

  attr_reader :color

  def initialize(color)
    @color = color
  end

  def get_input
    input = $stdin.getch
  end


end
