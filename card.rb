# ----- classs Card -----
class Card
  attr_accessor :rank, :suit   # shorthand for GET and SET methods
  
  def initialize(rank,suit)
    @rank = rank
    @suit = suit
  end

  def get_card
    return "#{self.rank} of #{self.suit}"
  end
end   # class Card

# ----- class Deck -----
class Deck
   def initialize
    suits = %w{S C D H}
    ranks = %w{2 3 4 5 6 7 8 9 10 J Q K A}

    @cards = []   # empty array of instances of class Card
    @hands = {}  # empty hash

    # create the deck
    suits.each do |suit|
      ranks.each do |rank|
        @cards << Card.new(rank,suit)
      end
    end
  end   # method initialize

  def shuffle
    @cards.shuffle!
  end   # method shuffle

  def cut
    cut_card = rand(21..31)
    printf("Cut the deck at card %d\n", cut_card)
    @cards = @cards[cut_card .. 51] + @cards[0..cut_card-1]
  end

  def deal(no_players)
    no_cards = 0
    # determine cards per player
    if no_players >= 0 && no_players <= 2
      no_cards = 10
    elsif (no_players <= 4)
      no_cards = 7
    else
      no_cards = 6
    end
    printf("The number of cards per player = %d\n", no_cards)
 
    # clear the hash. might be the next hand in a game.
    @hands.clear
    # create a hash with key: player number (an integer) and values: hand of cards (array of Card instances)
    for i in 1..no_players
      @hands[i] = []
    end

    # deal the cards by rounds to each player. Add the top card to the hand
    for i in 1..no_cards
      for j in 1..no_players
        @hands[j] << @cards.shift
      end
    end

    # Did it work - output the hands
    @hands.each_pair do |key, hand|
      printf("Player %d hand:\n\t", key)
      card_count = 0
      hand.map do |card|
        printf("%s, ", card.get_card)
      end
      printf("\n")
    end
  end   # method deal

  def output_deck
    print_count = 0
    @cards.each do |card|
      card.get_card
      printf("%s", card.get_card)
      print_count += 1
      if (print_count % 8 == 0)
        printf("\n")
      else
        printf(", ")
      end
    end
    printf("\n\n\n")
  end   # method output_deck

  def get_size
    return @cards.length
  end
end   # class Deck

class Hand
end   # class Hand

no_players = 4
deck = Deck.new
deck.shuffle
# deck.output_deck
deck.cut()
# deck.output_deck
deck.deal(no_players)
printf("The stock pile contains %d cards\n", deck.get_size)
deck.output_deck



