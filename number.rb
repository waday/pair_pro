class Player
  attr_accessor :sum

  def initialize
    @sum = 0
  end

  def add(x)
  	case x
  	when 'J','Q','K'
  	  x = 10
  	end
  	sum = @sum

    if x == 1
      sum += 11
      if sum > 21
      	x = 1
      else
        x = 11
      end
    end
    @sum += x
  end

  def reset
    @sum = 0
  end

  def judge
    if @sum > 21
      'BURST'
    else
      'SAFE'
    end
  end
end

class Game
  def initialize
    @player = Player.new
    @master = Player.new
    # ゲームの処理

    card = hit
    p "#{card}をひいた"
    @player.add(card)
    card = hit
    p "#{card}をひいた"
    @player.add(card)

    @master.add(hit)
    p 'ディーラーの片方の手札'
    p @master.sum
    @master.add(hit)
    start
  end

  def start
    #loop
    p '自分の手札の合計'
    p @player.sum

  end

  def hit
   cards = (1..10).to_a
   cards << 'J'
   cards << 'Q'
   cards << 'K'
   cards.sample
  end

end
Game.new