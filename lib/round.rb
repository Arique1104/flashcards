require "./lib/guess"
require "./lib/card"

class Round

  attr_reader :deck, :guesses, :correct_guesses

  def initialize(deck)
    @deck = deck
    @guesses = []
    @correct_guesses = 0
    @number_of_cards = deck.cards.count
  end

  def current_card
    @deck.cards[0]
  end

  def record_guess(response)
    @guesses << Guess.new(response.to_s, current_card)
    guess = @guesses.last
    if guess.correct?
      @correct_guesses += 1
    end
  end

  def percent_correct
    (@correct_guesses.to_f / @number_of_cards * 100).to_i
  end

  def start
    puts "Welcome! You're playing with #{@number_of_cards} cards"
    sleep 1.5
    puts "---------------------------------"
    sleep 1.5
    game
    puts "******* Game over! *******"
    sleep 1.5
    puts "You had #{@correct_guesses} correct guesses out of #{@number_of_cards} for a score of #{percent_correct}"
  end

  def game
    deck.cards.each_with_index do |card, index|
    puts "This is card number #{index + 1} out of #{@number_of_cards}"
    sleep 1.5
    puts "Question: #{card.question}"
    input = gets.chomp
    record_guess(input)
      puts "#{guesses.last.feedback}"
      sleep 1.5
    end
  end

end
