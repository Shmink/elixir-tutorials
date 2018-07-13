defmodule CardsTest do
  use ExUnit.Case
  doctest Cards

  test "create_deck makes 52 cards" do
    deck_length = length(Cards.create_deck)
    assert deck_length == 52
  end

  test "shuffling a deck randomises it" do
    deck = Cards.create_deck
    assert deck != Cards.shuffle(deck)
  end

  test "contains is detecting real and fake cards" do
    deck = Cards.create_deck
    assert Cards.contains?(deck, "Ace of Spades")
    refute Cards.contains?(deck, "Ace of Sad")
  end

  test "The correct amount of dealt cards from deal" do
    deck = Cards.create_deck
    {hand, _deck} = Cards.deal(deck, 5)
    hand_length = length(hand)
    assert hand_length == 5
  end

  
end
