defmodule Engine.Game.Entry do
  @enforce_keys [:player_name, :word]
  defstruct player_name: nil, word: nil

  def new(player, word) do
    %Engine.Game.Entry{player_name: player.name, word: word}
  end
end
