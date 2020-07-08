require './lib/card'
require './lib/guess'
require './lib/deck'
require './lib/round'
require "./lib/card_generator"

class FlashcardRunner

  filename = "./lib/cards.txt"
  cards = CardGenerator.new(filename).loader
  deck = Deck.new(cards)
  # require "pry"; binding.pry
  round = Round.new(deck)
  round.start

end
