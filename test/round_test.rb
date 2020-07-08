require 'minitest/autorun'
require 'minitest/pride'
require "./lib/guess"
require './lib/card'
require './lib/deck'
require "./lib/round"

class RoundTest < Minitest::Test

  def test_round_holds_and_has_access_to_deck
    card_1 = Card.new("What is the capital of Alaska?", "Juneau")
    card_2 = Card.new("Approximately how many miles are in one astronomical unit?", "93,000,000")
    deck = Deck.new([card_1, card_2])
    round = Round.new(deck)

    assert_equal 2, round.deck.cards.length
    assert_equal [], round.guesses
    assert_equal "What is the capital of Alaska?", round.current_card.question
    assert_equal "juneau", round.current_card.answer
  end

  def test_record_guess_can_count_and_give_current_card_and_feedback
    card_1 = Card.new("What is the capital of Alaska?", "Juneau")
    card_2 = Card.new("Approximately how many miles are in one astronomical unit?", "93,000,000")
    deck = Deck.new([card_1, card_2])
    round = Round.new(deck)

    round.record_guess("Juneau")

    assert_equal 1, round.guesses.count
    assert_equal 'Correct!', round.guesses.first.feedback
    assert_equal 1, round.correct_guesses
    assert_equal card_2, round.current_card
  end

  def test_record_guess_can_hold_two_guesses_correctly
    card_1 = Card.new("What is the capital of Alaska?", "Juneau")
    card_2 = Card.new("Approximately how many miles are in one astronomical unit?", "93,000,000")
    deck = Deck.new([card_1, card_2,])
    round = Round.new(deck)

    round.record_guess("Juneau")
    round.record_guess("2")

    assert_equal 2, round.guesses.count
    assert_equal 'Incorrect.', round.guesses.last.feedback
    assert_equal 1, round.correct_guesses
    assert_equal 50, round.percent_correct
  end

  def test_record_guess_edge_cases
    card_1 = Card.new("What is the capital of Alaska?", "Juneau")
    card_2 = Card.new("Approximately how many miles are in one astronomical unit?", "93,000,000")
    card_3 = Card.new("Is Taylor Swift the best artist of our era?", "yes")
    deck = Deck.new([card_1, card_2, card_3])
    round = Round.new(deck)
    edge = nil

    assert_equal 'yes', round.deck.cards[2].answer

    round.record_guess(5)
    round.record_guess('')
    round.record_guess(edge)

    assert_equal 0, round.percent_correct
    assert_nil nil, round.guesses.last.guess
    assert_equal 0, round.correct_guesses
  end

end
