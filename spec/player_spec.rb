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
end
