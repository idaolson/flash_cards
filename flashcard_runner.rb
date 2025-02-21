require './lib/card'
require './lib/turn'
require './lib/deck'
require './lib/round'
require './lib/card_generator'

# card_1 = Card.new("What is the capital of Alaska?", "Juneau", :Geography)
# card_2 = Card.new("The Viking spacecraft sent back to Earth photographs and reports about the surface of which planet?", "Mars", :STEM)
# card_3 = Card.new("Describe in words the exact direction that is 697.5° clockwise from due north?", "North north west", :STEM)

card_generator = CardGenerator.new("./lib/cards.txt")
deck = Deck.new(card_generator.cards())
round = Round.new(deck)

def start(round)

  puts "Welcome! You're playing with #{round.deck.count} cards"
  puts "-------------------------------------------------"

  card_count = round.deck.count
  list_of_categories = []

  while round.deck.count > 0
    puts "This is card number #{round.turns.length + 1} out of #{card_count}."
    puts "Question: #{round.current_card.question}"

    round.deck.cards.map {|card| card.category }.uniq.each do |category|
      list_of_categories.push(category) unless list_of_categories.include?(category)
    end

    round.take_turn(gets.chomp)
    puts round.turns.last.feedback
   end

  puts "****** Game over! ******"
  puts "You had #{round.number_correct.round} correct guesses out of #{card_count} for a total score of #{round.percent_correct.round}%."

  list_of_categories.each do |category|
    puts "#{category} - #{round.percent_correct_by_category(category).round}% correct"
  end
end

start(round)
