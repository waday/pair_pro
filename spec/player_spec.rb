require 'player'
RSpec.describe "Player" do
  before do
    @player = Player.new("YOU")
  end
  it {
    expect(@player.name).to eq("YOU")
  }
  it "given 5, returns 5 when call show_card" do
    @player.add(5)
    expect(@player.show_card).to eq(5)
  end
  it "release cards when call release_card" do
    @player.add(5)
    @player.release_card
    expect(@player.show_card_sum).to eq(0)
  end
  it "given J or Q, K. convert to 10" do
    @player.add('J')
    expect(@player.show_card_sum).to eq(10)
    @player.release_card
    @player.add('Q')
    expect(@player.show_card_sum).to eq(10)
    @player.release_card
    @player.add('K')
    expect(@player.show_card_sum).to eq(10)
  end
  it "given A. Convert to 11, if sum <= 10" do
    @player.add('A')
    expect(@player.show_card_sum).to eq(11)
  end
  it "given A. Convert to 1, if sum >= 11" do
    @player.add(6)
    @player.add(5)
    @player.add('A')
    expect(@player.show_card_sum).to eq(12)
  end
  it "output card array when call show_cards" do
    @player.add(3)
    @player.add(5)
    expect(@player.show_card_all).to match_array [3, 5]
    #expect(@player).
    #expect(@player.add(5).show_card).to eq(5)
    #not_to eq(5)
    #to be true
    #to be false
    #to be < 10
    #to be_between(1, 10).inclusive
    #expect(player).to respon_to(:add)
    #expect(player.add(2)).to be_integer
  end
  it "calc sum of cards when call show_card_sum" do
    @player.add(3)
    @player.add(5)
    @player.add(9)
    expect(@player.show_card_sum).to eq(17)
  end
  it "return true, if sum is over 21 when call burst?" do
    @player.add(10)
    @player.add(10)
    @player.add(2)
    expect(@player).to be_burst
  end
  it "not blackjack if cards that is not A and 10(or J,Q,K)" do
    expect(@player).not_to be_blackjack
  end
  it "not blackjack if cards that is more than 2" do
    @player.add('A')
    @player.add(10)
    @player.add('K')
    expect(@player).not_to be_blackjack
  end
  it "blackjack if cards that is A and 10(or J,Q,K)" do
    @player.add('A')
    @player.add(10)
    expect(@player).to be_blackjack
  end
end
