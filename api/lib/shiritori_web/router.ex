defmodule ShiritoriWeb.Router do
  use ShiritoriWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :auth do
    plug Shiritori.AuthPlug
  end

  scope "/api", ShiritoriWeb do
    pipe_through :api

    post "/players", SessionController, :create
  end

  scope "/api", ShiritoriWeb do
    pipe_through [:api, :auth]
  end
end
