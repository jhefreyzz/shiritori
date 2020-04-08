defmodule ShiritoriWeb.SessionController do
  use ShiritoriWeb, :controller

  def create(conn, _params) do
    player = Engine.Player.new("Jhef")

    conn
    |> put_resp_cookie("current_player", Shiritori.Auth.generate_token(player),
      http_only: true,
      max_age: 864_000
    )
    |> render("user.json", player: player)
  end
end
