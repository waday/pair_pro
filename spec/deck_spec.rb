require 'deck'
RSpec.describe "Deck" do
  before(:example) do
    @deck = Deck.new
  end
  it {
    expect(@deck.hit).to be_between(1,9).inclusive | eq('A') | eq('J') | eq('Q') | eq('K')
  }
end
