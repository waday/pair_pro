require_relative '../lib/dealer.rb'
require_relative '../lib/player.rb'
RSpec.describe "Dealer" do
  before(:example) do
     @dealer = Dealer.new("DEA")
     @dealer.add(5)
     @player = Player.new("YOU")
     @player.add(6)
     @players = [@dealer, @player]
  end
  it "dealer act hit, if sum <= 16 when call should_hit?" do
    expect(@dealer).to be_should_hit(@players)
  end
  it "dealer act stay, if sum > 16 when call should_hit?" do
    @dealer.add(10)
    @dealer.add(2)
    expect(@dealer).not_to be_should_hit(@players)
  end
  it "tell winner name when call tell_winner" do
    expect(@dealer.tell_winner(@players).shift).to eq('YOU')
  end
end
