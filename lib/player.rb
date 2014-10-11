class Player
  attr_accessor :name
  def initialize(name)
    @cards = Array.new
    @sum = 0
    @name = name
  end
  def add(card)
    @sum += convert_num card
    @cards.push(card)
  end
  def convert_num(card)
    case card 
      when 'J', 'Q', 'K'
        num = 10
      when 'A'
        num = 11
        num = 1 if @sum > 10
      else
        num = card
    end
    num
  end
  def show_card(num=-1)
    @cards[num]
  end
  def show_card_all
    @cards
  end
  def show_card_sum
    @sum
  end
  def release_card
    @cards = Array.new
    @sum = 0
  end
  def burst?
    if @sum > 21
      true
    else
      false
    end
  end
  def blackjack?
    if @cards.length == 2 && @cards.include?('A')
      return true if (@cards - ['J', 'Q', 'K', 10, 'A']).empty?
    end
    false
  end 
end
