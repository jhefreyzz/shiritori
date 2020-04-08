defmodule Engine.Dictionary.Entries do
  require Logger

  def load_entries do
    filename = "../data/records.json" |> Path.expand(__DIR__)

    Logger.info("Inserting entry to dictionary")

    with {:ok, body} <- File.read(filename), {:ok, json} <- Jason.decode(body) do
      Enum.map(json, fn record ->
        %{
          word: record["word"],
          definitions: record["definitions"],
          reading: record["reading"],
          isNoun: record["isNoun"]
        }
      end)
    end
  end
end
