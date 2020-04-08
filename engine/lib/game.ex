defmodule Engine.Game do
  defstruct word_history: [], entries: [], turn: nil, scores: %{}, winner: nil, error: nil

  alias Engine.Dictionary
  alias Engine.Game.Entry

  def new do
    %Engine.Game{}
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
end
