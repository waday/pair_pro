require 'player'
RSpec.describe "Player" do
  it "given 5, returns 5 when call show_card" do
    player = Player.new("YOU")
    player.add(5)
    expect(player.show_card).to eq(5)
  end
end
