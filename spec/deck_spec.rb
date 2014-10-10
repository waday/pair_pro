require 'deck'
RSpec.describe "Deck" do
  before(:example) do
    @deck = Deck.new
  end
  it {
    expect(@deck.hit).to be_between(1,9).exclusive.or eq('A').or eq('J').or eq('Q').or eq('K')
  }
end
