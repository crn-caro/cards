
# This is saying that there is a class Card. From this we can
# construct many cards, each having a suit and a number.
Card = Struct.new(:suit, :number)

# This next bit is a big of magic where we are "reopening"
# the Card class, and we are adding a method called "to_s"
# (meaning "to string"). This method is called by defualt
# when we ask to see the value as a string.
class Card
  def to_s
    # Internally, we number the cards starting at zero;
    # but since humans don't think that way, let's modify
    # this method to add 1 to the number.
    "%2s of %8s" % [ number+1, suit ]
  end
end

# This makes an Array, where each element is a String. And
# suits is initialized to an array ehich each of the values
# is the name of a suit.
suits = ['Spades', 'Diamonds', 'Clubs', 'Hearts']

# by the way, to debug your program, you can throw in
#     p <whatever>
#     exit
# and see the value of any variable at that point.
# "p" means print, but it sends the method #inspect
# to whatever it is printing. The #inspect method means:
# Let me see the thing the way the conmputer sees it.
# If you use "puts" (put string) that will make it more
# human-friendly. WHich is not always so friendly if you
# want to know what the program is doing.

# This means: Assign an empty array to the variable deck
deck = []

# So our next task is to interate in such a way that we
# can add items (aka elements) to the array deck, where
# each one is an instance of the Card class.

# Look up the method #each under the Enumeration mixin
# in the Pickaxe. It should also be defined on the Array
# class.
# For the #times method, look at the documentation for Number

# In the Perl language, they have a special, TMTOWTDI which
# "there's more than one way to do it"
# WAY #1
# suits.each_with_index do |suit, i|
#   13.times do |number|
#     deck[13*i + number] = Card.new(suit, number)
#   end
# end

# WAY #2
# This is using the "<<" operator which means: Tack onto the end
suits.each do |suit|
  13.times do |number|
    deck << Card.new(suit, number)
  end
end

# This is implicitly using the #to_s method
# puts deck

deck.shuffle!
# puts deck

debug = true

def peek(deck, start, finish)
  peek = ""
  deck[start..finish].each_with_index do |card, i|
    peek << "#{i}: #{card}"
  end.join(", ")
end

card_1_index = 0
card_2_index = 3
while card_2_index <= deck.size do
  puts "-- #{deck.size} cards left; initial cards: #{peek(deck, card_1_index, card_2_index+1)}"                  if debug
  puts "  card 1: #{deck[card_1_index]}; card 2: #{deck[card_2_index]}"            if debug
  if deck[card_1_index].suit == deck[card_2_index].suit
    range_to_delete = (card_1_index + 1)..(card_2_index - 1)
    puts "  Deleting inner 2 cards: #{deck[range_to_delete].join(', ')}"           if debug
    deck[range_to_delete] = []
  elsif deck[card_1_index].number == deck[card_2_index].number
    range_to_delete = card_1_index..card_2_index
    puts "  Deleting all 4 cards: #{deck[card_1_index..card_2_index].join(', ')}"  if debug
    deck[card_1_index..card_2_index] = []
  else
    card_1_index = card_1_index + 1
    card_2_index = card_2_index + 1
    puts "  Incrementing indices by 1"                                             if debug
  end
end
if deck.size == 0
  puts "You win"
else
  puts "You lose"
end

# Regarding loops. Basic for instance, loops this way
#   for i = 0 to 3
#     # do something with i
#   next

