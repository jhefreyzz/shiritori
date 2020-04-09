defmodule Shiritori.Game do
  @derive {Jason.Encoder, only: [:entries, :error, :id, :name, :scores]}
  defstruct id: nil,
            name: nil,
            word_history: [],
            entries: [],
            turn: 0,
            scores: %{},
            winner: nil,
            error: nil,
            status: 0

  alias Shiritori.Game
  alias Shiritori.Dictionary
  alias Shiritori.Game.Entry

  def new(game_name) do
    %Game{id: id(), name: game_name}
  end

  def add_word(game, word, player, _turn) do
    case !word_exists(game, word) do
      true ->
        case Dictionary.word_lookup(word) do
          {:error, :not_a_noun} ->
            %{game | error: "Entered word is not a noun!"}

          {:error, :word_not_found} ->
            %{game | error: "Entered word does not exist!"}

          {:ok, result} ->
            player_state = Map.put(player, :score, String.length(result.reading))

            updated_scores =
              Map.update(
                game.scores,
                player.id,
                player_state,
                fn player_state ->
                  Map.put(
                    player_state,
                    :score,
                    player_state.score + String.length(result.reading)
                  )
                end
              )

            entry = Entry.new(player, word)

            %{
              game
              | scores: updated_scores,
                word_history: [result.reading | game.word_history],
                entries: [entry | game.entries],
                error: nil
            }
        end

      false ->
        %{game | error: "Similar reading already exists!"}
    end
  end

  defp word_exists(game, word), do: Enum.member?(game.word_history, word)
  def id(), do: Integer.to_string(:rand.uniform(257_912_485_603), 16) |> String.downcase()
end
