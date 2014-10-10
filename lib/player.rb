class Player
  def initialize(name)
    @cards = Array.new
    @name = name
  end
  def add(num)
    @cards.push(num)
  end
  def show_card(num=0)
    @cards[num]
  end
end
