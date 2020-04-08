defmodule Shiritori.AuthPlug do
  import Plug.Conn
  require Logger
  def init(opts), do: opts

  def call(conn, _opts) do
    token = fetch_cookies(conn) |> Map.from_struct() |> get_in([:cookies, "current_player"])
    Logger.debug("Fetched token: #{token}")

    case Shiritori.Auth.authenticate(token) do
      {:ok, _token} ->
        conn

      {:error, :expired} ->
        conn |> send_resp(401, "Session expired!") |> halt()

      {:error, :invalid} ->
        conn |> send_resp(401, "Unauthorized") |> halt()
    end
  end
end
