defmodule Engine.Player do
  @enforce_keys [:name]
  defstruct [:id, :name, :score]

  def new(name) do
    id = :random.uniform(9999)
    %Engine.Player{id: id, name: name, score: 0}
  end
end
