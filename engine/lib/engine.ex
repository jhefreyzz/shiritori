defmodule Engine do
  use Application

  def start(_type, _args) do
    children = [
      {Registry, keys: :unique, name: Engine.GameRegistry},
      Engine.Dictionary,
      Engine.GameSupervisor
    ]

    opts = [strategy: :one_for_one, name: Engine.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
