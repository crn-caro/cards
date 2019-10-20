require './cards'

def unequal_decks(deck, expected_deck)
    deck.each_with_index do |card, i|
        return true if card != expected_deck[i]
    end
    return false
end

def test_round(example, deck, card_1_index, card_2_index, expected_deck, expected_deck_size, expected_card_1_index, expected_card_2_index)
    cards = Cards.new(true)
    deck, new_card_1_index, new_card_2_index = cards.play_round(deck, card_1_index, card_2_index)
    raise "Example #{example}: Wrong number of cards; was #{deck.size}; expected: #{expected_deck_size}" if deck.size != expected_deck_size
    raise "Example #{example}: wrong cards; was #{deck}; expected: #{expected_deck}" if unequal_decks(deck, expected_deck)
    raise "Example #{example}: wrong starting index; was: #{new_card_1_index}; expected: #{expected_card_1_index}" if new_card_1_index != expected_card_1_index
    raise "Example #{example}: wrong ending index; was: #{new_card_2_index}; expected: #{expected_card_2_index}" if new_card_2_index != expected_card_2_index
end

# 3 of   Spades, 12 of   Spades,  7 of   Hearts,  7 of   Spades,  8 of   Hearts
# Two cards removed
deck = [
    Card.new('Spades', 3),
    Card.new('Spades', 12),
    Card.new('Hearts', 7),
    Card.new('Spades', 7),
    Card.new('Hearts', 8)
]
expected_deck = [
    Card.new('Spades', 3),
    Card.new('Spades', 7),
    Card.new('Hearts', 8)
]
test_round("round1", deck, 0, 3, expected_deck, 3, 0, 3)

# 13 of    Clubs, 10 of   Spades, 13 of   Hearts, 13 of   Spades,  9 of   Spades
# Four cards removed
deck = [
    Card.new('Clubs', 12),
    Card.new('Spades', 9),
    Card.new('Hearts', 12),
    Card.new('Spades', 12),
    Card.new('Hearts', 8)
]
expected_deck = [
    Card.new('Hearts', 8)
]
test_round("round2", deck, 0, 3, expected_deck, 1, 0, 3)



def test_game(example, deck, expected_deck, expected_deck_size, expected_card_1_index, expected_card_2_index, expected_game_result)
    cards = Cards.new
    deck, new_card_1_index, new_card_2_index, game_result = cards.play_game(deck)
    raise "Example #{example}: Wrong number of cards" if deck.size != expected_deck_size
    raise "Example #{example}: wrong cards"           if deck != expected_deck
    raise "Example #{example}: wrong starting index; was: #{new_card_1_index}; expected: #{expected_card_1_index}"  if new_card_1_index != expected_card_1_index
    raise "Example #{example}: wrong ending index; was: #{new_card_2_index}; expected: #{expected_card_2_index}"    if new_card_2_index != expected_card_2_index
    raise "Example #{example}: wrong result: was: #{game_result}, expected: #{expected_game_result}" if game_result != expected_game_result
end

# 8 of Diamonds, 13 of    Clubs, 10 of   Spades, 13 of   Hearts, 13 of   Spades,  9 of   Spades
# Four cards removed
deck = [
    Card.new('Diamonds',  8),
    Card.new('Clubs',    13),
    Card.new('Spades',   10),
    Card.new('Hearts',   13),
    Card.new('Spades',   13),
    Card.new('Hearts',    9)
]
expected_deck = [
    Card.new('Diamonds',  8),
    Card.new('Hearts',    9)
]
test_game("game1", deck, expected_deck, 2, 0, 3, "lose")




# D13, D10, D2, S2, D10, C4, S13, C10, S4, S11
deck = [
    Card.new('Diamonds',  13),
    Card.new('Diamonds',  11),
    Card.new('Diamonds',   2),
    Card.new('Spades',     2),
    Card.new('Diamonds',  10),
    Card.new('Clubs',      4),
    Card.new('Spades',    13),
    Card.new('Clubs',     10),
    Card.new('Spades',     4),
    Card.new('Spades',    11)
]
expected_deck = [
    Card.new('Diamonds',  13),
    Card.new('Diamonds',  11),
    Card.new('Diamonds',   2),
    Card.new('Spades',     2),
    Card.new('Diamonds',  10),
    Card.new('Clubs',      4),
    Card.new('Spades',    13),
    Card.new('Clubs',     10),
    Card.new('Spades',     4),
    Card.new('Spades',    11)
]
test_round("round3", deck, 0, 3, expected_deck, 10, 1, 4)




# S1, D13, D10, D2, S2, D10, C4, S13, C10, S4, S11
deck = [
    Card.new("Spades",     1),
    Card.new('Diamonds',  13),
    Card.new('Diamonds',  11),
    Card.new('Diamonds',   2),
    Card.new('Spades',     2),
    Card.new('Diamonds',  10),
    Card.new('Clubs',      4),
    Card.new('Spades',    13),
    Card.new('Clubs',     10),
    Card.new('Spades',     4),
    Card.new('Spades',    11)
]
expected_deck = [
    Card.new("Spades",     1),
    Card.new('Diamonds',  13),
    Card.new('Diamonds',  11),
    Card.new('Diamonds',   2),
    Card.new('Spades',     2),
    Card.new('Diamonds',  10),
    Card.new('Clubs',      4),
    Card.new('Spades',    13),
    Card.new('Clubs',     10),
    Card.new('Spades',     4),
    Card.new('Spades',    11)
]
test_round("round4", deck, 0, 3, expected_deck, 11, 1, 4)
test_round("round5", deck, 1, 4, expected_deck, 11, 2, 5)

expected_deck = [
    Card.new("Spades",     1),
    Card.new('Diamonds',  13),
    Card.new('Diamonds',  11),
    Card.new('Diamonds',  10),
    Card.new('Clubs',      4),
    Card.new('Spades',    13),
    Card.new('Clubs',     10),
    Card.new('Spades',     4),
    Card.new('Spades',    11)
]
test_round("round6", deck, 2, 5, expected_deck,  9, 2, 5)
test_round("round7", deck, 2, 5, expected_deck,  9, 3, 6)


expected_deck = [
    Card.new("Spades",     1),
    Card.new('Diamonds',  13),
    Card.new('Diamonds',  11),
    Card.new('Spades',     4),
    Card.new('Spades',    11)
]
################### SUNDAY
test_round("round8", deck, 3, 6, expected_deck,  5, 0, 3)




# # D13, D10, D2, S2, D10, C4, S13, C10, S4, S11
# deck = [
#     Card.new('Diamonds',  13),
#     Card.new('Diamonds',  11),
#     Card.new('Diamonds',   2),
#     Card.new('Spades',     2),
#     Card.new('Diamonds',  10),
#     Card.new('Clubs',      4),
#     Card.new('Spades',    13),
#     Card.new('Clubs',     10),
#     Card.new('Spades',     4),
#     Card.new('Spades',    11)
# ]
# expected_deck = [
#     Card.new('Diamonds',  7),
#     Card.new('Hearts',    8)
# ]
# test_game("game2", deck, expected_deck, 2, 0, 3, "win")
