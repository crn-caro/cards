  # This makes an Array, where each element is a String. And
  # suits is initialized to an array ehich each of the values
  # is the name of a suit.
  SUITS = ['Spades', 'Diamonds', 'Clubs', 'Hearts']

# ABANDONING THIS STRATEGY BECUASE WE DON'T LIKE SPECIFYING 0 for ACE
# This is saying that there is a class Card. From this we can
# construct many cards, each having a suit and a number.
# Card = Struct.new(:suit, :number)

# This next bit is a big of magic where we are "reopening"
# the Card class, and we are adding a method called "to_s"
# (meaning "to string"). This method is called by defualt
# when we ask to see the value as a string.
class Card
  include Comparable
  attr_accessor :suit, :number
  def initialize(suit, number)
    @suit = suit
    @number = number - 1
  end
  def <=>(other)
    return 0 if suit == other.suit && number == other.number
    return 1
  end
  def to_s
    # Internally, we number the cards starting at zero;
    # but since humans don't think that way, let's modify
    # this method to add 1 to the number.
    "%2s of %8s" % [ number+1, suit ]
  end

end

class Cards
  attr_accessor :debug

  def initialize(debug = false)
    @debug = debug
  end

  def peek(deck, start, finish)
    peek = ""
    deck[start..finish].each_with_index do |card, i|
      peek << "#{i}: #{card}"
    end.join(", ")
  end

  def play_round(deck, card_1_index, card_2_index)
    can_continue = true
    puts "\n-- #{deck.size} cards left; cards: #{peek(deck, 0, deck.size)}"            if debug
    puts "  card 1: index = #{card_1_index} #{deck[card_1_index]}; card 2: index = #{card_2_index} #{deck[card_2_index]}"            if debug
    if deck[card_1_index].suit == deck[card_2_index].suit
      range_to_delete = (card_1_index + 1)..(card_2_index - 1)
      puts "  Deleting inner 2 cards: #{deck[range_to_delete].join(', ')}"           if debug
      deck[range_to_delete] = []

    # Same number
    elsif deck[card_1_index].number == deck[card_2_index].number
      range_to_delete = card_1_index..card_2_index
      puts "  Deleting all 4 cards: #{deck[card_1_index..card_2_index].join(', ')}"  if debug
      deck[card_1_index..card_2_index] = []
      puts "  afterwards: #{deck.join(', ')}"                                        if debug
      puts "    #{deck.join(', ')}"                                                  if debug

      # maybe correct
      if card_1_index >= 3
        card_1_index = card_1_index - 3
        card_2_index = card_2_index - 3
      else
        card_1_index = 0
        card_2_index = 3
      end

      # We should only increment the higher index if, after the increment,
      # it can still index a card in the deck. So, for example, if the deck
      # has 4 cards, the highest index is 3. If we come in here with a card_2_index
      # equal to 3, we don't want it to increment to 4, because deck[4] doesn't
      # exist.
    elsif (card_2_index + 1) < deck.size
      card_1_index = card_1_index + 1
      card_2_index = card_2_index + 1
      puts "  Incrementing indices by 1"                                             if debug
    else
      # Can't continue; by definition "lose"
      puts "  NOT incrementing"                                                      if debug
      can_continue = false
    end

    [ deck, card_1_index, card_2_index, can_continue ]
  end

  def play_game(deck, debug = false)

    card_1_index = 0
    card_2_index = 3

    can_continue = true
    while deck.size > 0 && can_continue && (card_2_index+1) <= deck.size do
      deck, card_1_index, card_2_index, can_continue = play_round(deck, card_1_index, card_2_index)
      puts "******** card_1_index: #{card_1_index}; card_2_index: #{card_2_index}"   if debug
    end

    game_result = "lose"

    if deck.size == 0
      game_result = "win"
    end

    [ deck, card_1_index, card_2_index, game_result ]

  end
end
