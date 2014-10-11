#coding: utf-8
require_relative 'lib/player'
require_relative 'lib/dealer'
require_relative 'lib/deck'

class Game
  def initialize
    @deck = Deck.new
    @player = Player.new("YOU")
    @dealer = Dealer.new("DEA")
    @players = Array[@player, @dealer]
    title
  end

  def clear_disp
    print "\033[2J"
  end

  def title

    clear_disp

    puts <<-'EOS'

       　　　　―＼＼＼＼＼
       　　―　　　　　　　　　｀｀
       　／　　　　　　　　　　　　 ＼
       　／　　　　　　　　　　　　　　ヽ
       　／　　　　　　　　　　　　　　　し
       　/|　　　　　　　　 /ルﾉﾙ　　　　ノ
       　　|/|　　　　　　 /(O ) ﾉ　´ヽ　 彡
       　　　|/|　　　 /|/＼　　/　|6/　 彡
       　　　　|/|/|/く　　　＼|￣￣￣￣￣|
       　　|￣￣ヽ　―‐　┌┘
       　　|　　　　＼⌒ ＿|
       　　　　　　　 ￣
 ____  _        _    ____ _  __   _   _    ____ _  __
| __ )| |      / \  / ___| |/ /  | | / \  / ___| |/ /
|  _ \| |     / _ \| |   | ' /_  | |/ _ \| |   | ' / 
| |_) | |___ / ___ \ |___| . \ |_| / ___ \ |___| . \ 
|____/|_____/_/   \_\____|_|\_\___/_/   \_\____|_|\_\
                                                      
    EOS

    puts 'PRESS ANY KEY TO START'
    if gets
      clear_disp
      start
    end
  end

  def start
    puts '-----------------------------'
    puts 'カード配布'
    puts '-----------------------------'
    @player.add(@deck.hit)
    @player.add(@deck.hit)
    @dealer.add(@deck.hit)
    @dealer.add(@deck.hit)

    loop do
      puts ''
      puts '-----------------------------'
      puts 'プレイヤーのターン'
      puts '-----------------------------'
      puts "#{@dealer.name}:[#{@dealer.show_card(0)}, *]"
      puts "#{@player.name}:#{@player.show_card_all}(#{@player.show_card_sum})"
      puts ''
      puts 'hit or stay? (1:hit, 2:stay) [2]:'
      cmd = gets.chomp.to_i
      if cmd == 1
        @player.add(@deck.hit)
        puts "[info] #{@player.name}は#{@player.show_card}のカードを引きました"
        puts ''
      else
        puts 'stay'
        puts ''
        break
      end
      break if check_burst @player
    end

    loop do

      puts ''
      puts '-----------------------------'
      puts 'ディーラーのターン'
      puts '-----------------------------'
      puts "#{@dealer.name}:#{@dealer.show_card_all}(#{@dealer.show_card_sum})"
      puts "#{@player.name}:#{@player.show_card_all}(#{@player.show_card_sum})"
      if @dealer.should_hit?(@players)
        @dealer.add(@deck.hit)
        puts "[info] #{@dealer.name}は#{@dealer.show_card}のカードを引きました"
        puts ''
      else 
        puts 'stay'
        puts ''
        break
      end
      check_burst @dealer
    end

    match
    continue

  end

  def check_burst(player)
    if player.burst?
      puts "BURST!\s#{player.show_card_all}(#{player.show_card_sum})\n#{player.name} LOSE"
      puts ''
      return true
    end
    false
  end

  def match
    puts '-----------------------------'
    puts '勝敗結果'
    puts '-----------------------------'

    winner = @dealer.tell_winner @players
    if @players.length == winner.length || winner.length == 0
      puts "DRAW"
    else
      puts "#{winner} WIN"
    end
    puts ''
  end

  def continue
    puts 'continue? (1:yes, 2:no) [1]:'
    if gets.chomp.to_i == 2
      exit 0
    else
      initialize
    end
  end

end

Game.new
