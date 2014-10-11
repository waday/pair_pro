class Deck
  def initialize
    @cards = Array.new
    (2..10).each do |i|
      @cards << i
      @cards << i
      @cards << i
      @cards << i
    end
    Array['A', 'J', 'Q', 'K'].each do |i|
      @cards << i
    end
    @cards.shuffle!
  end
  def hit
    @cards.shift
  end
end
