class Player
  attr_accessor :name
  def initialize(name)
    @cards = Array.new
    @sum = 0
    @name = name
  end
  def add(card)
    case card 
      when 'J', 'Q', 'K'
        num = 10
      when 'A'
        num = 11
        num = 1 if @sum > 10
      else
        num = card
    end
    @sum += num
    @cards.push(card)
  end
  def show_card(num=0)
    @cards[num]
  end
  def show_card_all
    @cards
  end
  def show_card_sum
    @sum
  end
end
