defmodule Cards do
  @moduledoc """
    Provides methods for creating and handling a deck of cards.
  """

  @doc """
    Returns a list of strings representing a deck of playing cards.
  """
  def create_deck do
    values = ["Ace", "Two", "Three", "Four", "Five", "Six",
              "Seven", "Eight", "Nine", "Ten", "Jack", "Queen", "King"]

    suits = ["Spades", "Clubs", "Hearts", "Diamonds"]

    for suit <- suits, value <- values do
      "#{value} of #{suit}"
    end
    
  end

  @doc """
    Returns a shuffled list of cards once given a list of cards.
  """
  def shuffle(deck) do
    Enum.shuffle(deck)
  end

  @doc """
    Determines whether a deck contains a given card.

  ## Examples

      iex> deck = Cards.create_deck
      iex> Cards.contains?(deck, "Ace of Spades")
      true

  """
  def contains?(deck, card) do
    Enum.member?(deck, card)
  end

  @doc """
    Divides a deck into a hand and the remainder of the deck.
    The `hand_size` argument indicates how many cards should
    be in the hand.

  ## Examples

      iex> deck = Cards.create_deck
      iex> {hand, _deck} = Cards.deal(deck, 1)
      iex> hand
      ["Ace of Spades"]

  """
  def deal(deck, hand_size) do
    Enum.split(deck, hand_size)
  end

  def save(deck, filename) do
    binary = :erlang.term_to_binary(deck)
    File.write(filename, binary)
  end

  @doc """
  Another way that the above can have been done is doing both the pattern
  matching and the checking in one block like the following

  ## Examples

      case File.read(filename) do
        {:ok, binary} -> :erlang.binary_to_term(binary)
        {:error, _reason} -> "The file does not exist."
      end

  The first one I think is more readable but the second is more concise and
  also makes use of _ which in pattern matching is like saying that you know
  something will be there but you don't care about it.
  """
  def load(filename) do
    {status, binary} = File.read(filename)

    # We could have used an if statment here but pattern matching in elixir
    # and case statements are better like the following to check if a file exists

    case status do
      :ok -> :erlang.binary_to_term(binary)
      :error -> "The file does not exist."
    end
  end

  @doc """
  deck = Cards.create_deck
  deck = Cards.shuffle(deck)
  hand = Cards.deal(deck, hand_size)

  The point of this method was to minimise the amount of methods a user would have
  to call as the order is pretty similar. Above is how you might normally do it but
  we can improve it with the pipe operator |>
  """
  def create_hand(hand_size) do
    Cards.create_deck
    |> Cards.shuffle
    |> Cards.deal(hand_size) # Notice how the first argument isn't necessary as the data is being piped on our behalf.
  end

"""
  def hello do
    :world
  end

  def factorial(x) do
    if x <= 1 do
      1
    end
    result = x * factorial(x-1)
  end
"""

end
