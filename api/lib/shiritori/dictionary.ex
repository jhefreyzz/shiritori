defmodule Shiritori.Dictionary do
  use GenServer

  def start_link(_opts) do
    GenServer.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def word_lookup(word) do
    GenServer.call(__MODULE__, {:lookup, word})
  end

  def init(:ok) do
    state = Shiritori.Dictionary.Entries.load_entries()
    {:ok, state}
  end

  def handle_call({:lookup, entry}, _from, state) do
    case word_lookup(entry, state) do
      nil ->
        {:reply, {:error, :word_not_found}, state}

      result ->
        case result.isNoun do
          true ->
            {:reply, {:ok, result}, state}

          false ->
            {:reply, {:error, :not_a_noun}, state}
        end
    end
  end

  defp word_lookup(word, entries) do
    Enum.find(entries, &(&1.word === word || &1.reading === word))
  end
end
