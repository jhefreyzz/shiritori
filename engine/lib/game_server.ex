defmodule Engine.GameServer do
  use GenServer

  def start_link(game_name) do
    GenServer.start_link(__MODULE__, :ok, name: via_tuple(game_name))
  end

  def summary(game_name) do
    GenServer.call(via_tuple(game_name), :get_summary)
  end

  def add_entry(game_name, word, player) do
    GenServer.call(via_tuple(game_name), {:add_entry, word, player})
  end

  defp via_tuple(game_name) do
    {:via, Registry, {Engine.GameRegistry, game_name}}
  end

  def init(:ok) do
    state = Engine.Game.new()
    {:ok, state}
  end

  def handle_call({:add_entry, word, player}, _from, state) do
    updated_state = Engine.Game.add_word(state, word, player, [])
    {:reply, summarize(updated_state), updated_state}
  end

  def handle_call(:get_summary, _from, state) do
    {:reply, summarize(state), state}
  end

  defp summarize(game) do
    %{
      entries: game.entries,
      scores: game.scores,
      error: game.error
    }
  end

  def game_pid(game_name) do
    game_name
    |> via_tuple()
    |> GenServer.whereis()
  end
end
