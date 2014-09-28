class Player
	attr_accessor :name
  def initialize(name)
		@cards = Array.new
		@name = name
  end

  def add(card)
		@cards.push(card)
  end

  def reset
    @cards = Array.new
  end

	def show_card_sum
		card_sum = 0
		@cards.each do |card|
	  	case card
	  		when 'J','Q','K'
	  	  	add_num = 10
				when '1'
		      if @sum + 11 > 21
		        add_num = 1
		      else
		        add_num = 11
		      end
				else
					add_num = card
	  	end
	    card_sum += add_num
		end
		card_sum
	end

	def show_card(num=-1)
		if num.to_i == -1
			@cards[(@cards.length.to_i - 1)]
		else
			@cards[num]
		end
	end

	def show_card_all
		@cards
	end

  def judge
		sum = show_card_sum.to_i
    if sum > 21
      'BURST'
    else
      'SAFE'
    end
  end
end

class Deck
	def initialize
		@cards = Array.new
		(1..10).each do |i|
			@cards << i
			@cards << i
			@cards << i
			@cards << i
		end
		Array['J','Q','K'].each do |i|
			@cards << i
			@cards << i
			@cards << i
			@cards << i
		end
		@cards.shuffle!
	end
  def hit
		card = @cards.shift
		card
  end
end


class Game
  def initialize
		@deck = Deck.new
    @player = Player.new("YOU")
    @master = Player.new("DEA")
		@players = Array[@player, @master]
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
		@master.add(@deck.hit)
		@master.add(@deck.hit)

		loop do
			puts ''
			puts '-----------------------------'
			puts 'プレイヤーのターン'
			puts '-----------------------------'
	    puts "#{@master.name}:[#{@master.show_card(0)}, *]"
    	puts "#{@player.name}:#{@player.show_card_all}(#{@player.show_card_sum})"
			puts ''
			puts 'hit or stay? (1:hit, 2:stay) :[2]'
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
			check_burst @player
		end

		loop do
			puts ''
			puts '-----------------------------'
			puts 'ディーラーのターン'
			puts '-----------------------------'
	    puts "#{@master.name}:#{@master.show_card_all}(#{@master.show_card_sum})"
    	puts "#{@player.name}:#{@player.show_card_all}(#{@player.show_card_sum})"
			if @master.show_card_sum.to_i <= 16
				@master.add(@deck.hit)
				puts "[info] #{@master.name}は#{@master.show_card}のカードを引きました"
				puts ''
			else 
				puts 'stay'
				puts ''
				break
			end
			check_burst @master
		end

		match @players

	end

	def check_burst(player)
		if player.judge == 'BURST'
			puts "BURST!\s#{@player.show_card_all}(#{@player.show_card_sum})\n#{player.name} LOSE"
			puts ''
			match @players
		end
	end

	def match(player)
		puts '-----------------------------'
		puts '勝敗結果'
		puts '-----------------------------'

		hiscore=0
		winner = Array.new
		@players.each do |player|
			score = player.show_card_sum
			if score <= 21
				if score > hiscore
					winner.clear
					winner.push(player.name)
					hiscore = score
				elsif score == hiscore
					winner.push(player.name)
				end
			end
		end

		puts "#{winner} WIN"
		puts ''
		continue?
	end

	def continue?
		puts 'continue? (1:yes, 2:no) :[1]'
		if gets.chomp.to_i == 2
			exit 0
		else
			initialize
		end
	end

end

Game.new
