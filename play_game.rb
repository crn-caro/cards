require './cards'

deck = []
SUITS.each do |suit|
   13.times do |number|
     deck << Card.new(suit, number + 1)
   end
 end
 deck.shuffle!

Cards.new.play_game(deck)
