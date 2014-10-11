#coding: utf-8
require './lib/player'
class Dealer < Player

  def should_hit?(players)
    winner = tell_winner(players)
    return false if winner.include?(name) && winner.length == 1
    return true if show_card_sum.to_i <= 16
    false
  end

  def tell_winner(players)
    hiscore=0
    winner = Array.new
    players.each do |player|
      score = player.show_card_sum
      if score <= 21
        score = 100 if player.blackjack?
        if score > hiscore || player.blackjack?
          winner.clear
          winner.push(player.name)
          hiscore = score
        elsif score == hiscore
          winner.push(player.name)
        end
      end
    end
    winner
  end

end
