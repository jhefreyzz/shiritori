defmodule ShiritoriWeb.Router do
  use ShiritoriWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", ShiritoriWeb do
    pipe_through :api
  end
end
