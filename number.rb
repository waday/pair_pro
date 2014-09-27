class Player
  attr_accessor :sum, :cards

  def initialize
    @sum = 0
    @cards = []
  end

  def add(card)
    #x = card
    #x = change(x)
    #@sum += x
    @cards << card
  end

  def calc
    sum = 0
    cards.each do |n|
      sum += change(n, sum)
    end
    @sum = sum
  end

  #def judge
  def burst?
    if @sum > 21
      true
    end
  end

  def black_jack?
    # Aと「10」または絵札の組み合わせが最も強い
    cards.include?('A') and cards.one? {|c| ten?(c) }
  end

  private
  def ten?(card)
    case card
    when 'J','Q','K',10
      true
    end
  end

  def change(card, sum)
    case card
    when 'J','Q','K'
      card = 10
    when 'A'
      sum += 11
      if sum > 21
        card = 1
      else
        card = 11
      end
    end
    card
  end

end

class Game

  # attr_accessor :stack

  def initialize
    # 山札を減らす処理書くなら
    # @stack = (2..10).to_a
    # @stack << 'A'
    # @stack << 'J'
    # @stack << 'Q'
    # @stack << 'K'

    @player = Player.new # プレイヤー
    @master = Player.new # ディーラー
    # ゲームの処理

    # プレイヤーの最初の行動
    card = hit
    puts "あなたは#{card}をひいた"
    @player.add(card)
    card = hit
    puts "あなたは#{card}をひいた"
    @player.add(card)
    @player.calc

    # ディーラーの行動
    puts "ディーラーは2枚カードをひいた"
    card = hit
    @master.add(hit)
    puts "ディーラーの片方の手札: #{ card }"
    @master.add(hit)
    @master.calc
    start
  end

  def start
    loop do
      puts "自分の手札: #{ @player.cards.join(' ') }"
      puts "* あなたの番 *"
      puts '1:hit 2:stay'
      cmd = gets.chomp.to_i
      if cmd == 1
        card = hit
        puts "あなたは#{ card }をひいた"
        @player.add(card)
        @player.calc
        # チェック
        if @player.burst?
          puts "自分の手札: #{ @player.cards.join(' ') } * 自分の手札の合計: #{ @player.sum }"
          puts "あなたの負けてしまった..."
          break
        end
      else
        puts 'あなたはstayを選んだ'
        puts '* ディーラーの番 *'
        master_play
        # チェック
        if  @master.burst?
          puts "ディーラーの手札: #{ @master.cards.join(' ') } * ディーラーの手札の合計: #{ @master.sum }"
          puts "あなたはディーラーに勝利した！"
          break
        end
        # 判定
        puts "勝負！！"
        puts "自分の手札: #{ @player.cards.join(' ') } * 自分の手札の合計: #{ @player.sum }"
        puts "ディーラーの手札: #{ @master.cards.join(' ') } * ディーラーの手札の合計: #{ @master.sum }"
        battle( @player, @master )
        break
      end

    end
  end


  def master_play
    while @master.sum <= 16
      #ディーラーは、カードの合計値が16以下の 場合は、引き続けなくてはならない
      p "ディーラーは1枚カードをひいた"
      @master.add(hit)
      @master.calc
    end
    #ディーラーは、カードの合計値が17以上の 場合は、それ以上カードを引くことができない
  end

  def hit
   cards = (2..10).to_a
   cards << 'A'
   cards << 'J'
   cards << 'Q'
   cards << 'K'
   # 山札を減らす処理かく？
   # card = cards.sample
   # @stack.delete(card)
   # card
   cards.sample
  end

  def battle(player, master)
    # カードの合計値が21に近い方が勝ち
    if player.sum > master.sum
      #
      p "あなたはディーラーに勝利した！"
    elsif player.sum == master.sum
      # Aと「10」または絵札の組み合わせが最も強い
      if player.black_jack? and master.black_jack?
        p "引き分け"
      elsif player.black_jack?
        p "あなたはディーラーに勝利した！"
      elsif master.black_jack?
        p "あなたの負けてしまった..."
      else
        p "引き分け"
      end
    else
      p "あなたの負けてしまった..."
    end

  end

end

# puts "NEW GAME"
# Game.new
