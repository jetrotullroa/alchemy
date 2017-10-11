defmodule TehHoodWeb.Router do
  use TehHoodWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", TehHoodWeb do
    pipe_through :api
  end
end
