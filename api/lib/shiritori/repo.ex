defmodule Shiritori.Repo do
  use Ecto.Repo,
    otp_app: :shiritori,
    adapter: Ecto.Adapters.Postgres
end
