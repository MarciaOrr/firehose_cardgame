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
    @cards = []   # empty array of instances of class Card
    
    suits = %w{S C D H}
    ranks = %w{A 2 3 4 5 6 7 8 9 10 J Q K}
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
    cut_card = rand(18..34)
    # printf("\tCut the deck at card %d\n", cut_card)
    @cards = @cards[cut_card .. 51] + @cards[0..cut_card-1]
  end

  def get_next_card
    @cards.shift
  end   # method deal

  def get_card_count
    return @cards.length
  end   # end method get_card_count

  def output_deck
    print_count = 0
    @cards.each do |card|
      card.get_card
      printf("%s\n", card.get_card)
      print_count += 1
      if (print_count % 13 == 0)
        printf("\n")
      else
        printf(", ")
      end
    end
    printf("\n\n\n")
  end   # method output_deck
end   # class Deck

class Hand
  attr_accessor :no_players

  def initialize(no_players)
    @no_players = no_players

    # Prepare the deck for the hand
    #   Shuffle
    #   Cut the deck
    @deck = Deck.new
    @deck.shuffle
    @deck.cut

    # Prepare hash to hold each players cards. key: int for player; value: array of cards
    @hands = {}
    @hands.clear
    for i in 1..no_players
      @hands[i] = []
    end

    @stock_pile = []
    @discard_pile = []
  end   # method Initialize

  def deal_cards
    # Deal the cards to each player
    #   Determine number of cards per player based upon no_players
    #   DEAL THE CARDS
    no_cards = 0
    # determine cards per player
    if self.no_players >= 0 && self.no_players <= 2
      no_cards = 10
    elsif (self.no_players <= 4)
      no_cards = 7
    else
      no_cards = 6
    end
    printf("The number of cards per player = %d\n", no_cards)
    
    printf("Before the deal. deck size = %d cards.\n", @deck.get_card_count)
    # deal the cards by rounds to each player. Add the top card to the hand
    for i in 1..no_cards
       for j in 1..no_players
       @hands[j] << @deck.get_next_card
      end
    end
    printf("After the deal. deck size = %d cards.\n", @deck.get_card_count)
  end   # method deal_cards

  def prepare_piles
    # PREPARE STOCK and DISCARD PILES. Each is an array of class Card.
    #   Move remaining cards in deck to @stock_pile array
    #   Move top card in @stock_pile to create @discard_pile
    limit = @deck.get_card_count - 1
    for i in 0..limit
      @stock_pile << @deck.get_next_card
    end
    @discard_pile.push @stock_pile.delete_at(0)
  end   # method prepare_piles

   def sort_hand(cardArray)
   end

  # Play the Hand
  def sort_hand()
    players = @hands.keys
    players.each do |player|
      @cards = @hands[player]
    end
  end

  def draw_card
    for i in 1..no_players
      @hands[i] << @stock_pile.shift
    end
  end
 

  # --- output methods
  def print_all_hands
    players = @hands.keys
    players.each do |player|
      print_player_hand(player)
    end
  end   # end method print_all_hands

  def print_player_hand(player_id)
    if @hands.has_key?(player_id)
      hand = @hands[player_id]
      printf("Player %d: ", player_id)
      hand.map do |card|
        printf(" %s   ",card.get_card)
      end
      printf("\n")
    else
      printf("Hash hands does not have key %s\n", player_id)    
    end
  end   # method print_player_hand

  def print_piles
    discard_top_card = @discard_pile[@discard_pile.length-1]
    printf("The top card in the discard pile contains card %s\n", discard_top_card.get_card)
  
    printf("Printing the STOCK pile with %d cards.\n", @stock_pile.length)
    print_count = 0
    @stock_pile.map do |card|
      printf("%s   ",card.get_card)
      print_count += 1
      if (print_count % 10 == 0)
        printf("\n")
      end
    end
  end   # method print_piles
end   # class Hand

# main
no_deals = 1
player_count = 4

for i in 1..no_deals
  printf("\n\n\nThis is deal number %d of %d\n", i, no_deals)
  hand = Hand.new(player_count)
  hand.deal_cards
  hand.prepare_piles
  hand.print_all_hands
  hand.print_piles

  # loop 5 more times and add cards to hands
  for i in 1..5
      hand.draw_card
  end

  printf("\n\n\n")
  hand.print_all_hands
  hand.print_piles
end
