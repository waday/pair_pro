class Number
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

  def hit
   cards = (1..10).to_a
   cards << 'J'
   cards << 'Q'
   cards << 'K'
   cards.sample
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

player = Number.new

p hit_tmp = player.hit
player.add(hit_tmp)
p player.sum
p player.judge

p hit_tmp = player.hit
player.add(hit_tmp)
p player.sum
p player.judge

p hit_tmp = player.hit
player.add(hit_tmp)
p player.sum
p player.judge

p hit_tmp = player.hit
player.add(hit_tmp)
p player.sum
p player.judge

p hit_tmp = player.hit
player.add(hit_tmp)
p player.sum
p player.judge