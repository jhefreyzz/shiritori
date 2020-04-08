defmodule ShiritoriWeb.SessionView do
  use ShiritoriWeb, :view

  def render("user.json", %{player: player}) do
    %{id: player.id, name: player.name}
  end
end
