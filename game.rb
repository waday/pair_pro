#coding: utf-8
require_relative 'lib/player'
require_relative 'lib/deck'

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

		match

	end

	def check_burst(player)
		if player.show_card_sum.to_i > 21
			puts "BURST!\s#{player.show_card_all}(#{player.show_card_sum})\n#{player.name} LOSE"
			puts ''
			match
		end
	end

	def match
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
