defmodule Shiritori.Player do
  @enforce_keys [:name]
  defstruct [:id, :name, :score]

  def new(name) do
    id = :random.uniform(9999)
    %Shiritori.Player{id: id, name: name, score: 0}
  end
end
