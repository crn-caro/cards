require './cards'

wins = 0
losses = 0
games = 10000
pip_cards = 2

def generate_deck(pip_cards)
  starting_deck = []
  SUITS.each do |suit|
    pip_cards.times do |number|
      starting_deck << Card.new(suit, number + 1)
    end
  end
  starting_deck.shuffle!
end

games.times do

  starting_deck = generate_deck(pip_cards)
  deck = starting_deck.dup

  # puts "Starting deck: #{deck.join(', ')}"
  deck, card_1_index, card_2_index, game_result = Cards.new.play_game(deck)
  # puts "Remaining deck: #{deck.join(', ')} (#{deck.size} cards left)"
  # puts "Result: #{game_result}"
  if game_result == "win"
    puts "\n#{starting_deck.join(', ')}"
  end
  losses += 1 if game_result == "lose"
  wins += 1 if game_result == "win"
end

puts "wins:   #{wins}"
puts "losses: #{losses}"
puts "% wins: #{1.0*wins/(wins+losses)}"
