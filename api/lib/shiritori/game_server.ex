defmodule Shiritori.GameServer do
  use GenServer

  alias Shiritori.Game

  def start_link(_) do
    GenServer.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def summary() do
    GenServer.call(__MODULE__, :get_summary)
  end

  def create_game(game) do
    GenServer.call(__MODULE__, {:create_game, game})
  end

  def add_entry(game_id, word, player) do
    GenServer.call(__MODULE__, {:add_entry, game_id, word, player})
  end

  def init(:ok) do
    state = %{}
    {:ok, state}
  end

  def handle_call({:create_game, %Game{id: id} = game}, _from, state) do
    updated_state = Map.put(state, id, game)
    {:reply, summarize(updated_state), updated_state}
  end

  def handle_call({:add_entry, game_id, word, player}, _from, state) do
    game_state =
      Map.get(state, game_id)
      |> Game.add_word(word, player, [])

    updated_state = Map.put(state, game_id, game_state)
    {:reply, summarize(updated_state), updated_state}
  end

  def handle_call(:get_summary, _from, state) do
    {:reply, summarize(state), state}
  end

  defp summarize(state) do
    Enum.map(state, fn {id, game} ->
      %{
        id => %{
          entries: game.entries,
          error: game.error,
          id: game.id,
          name: game.name,
          scores: game.scores,
          turn: game.turn,
          status: game.status
        }
      }
    end)
  end
end
