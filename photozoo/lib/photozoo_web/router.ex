defmodule PhotozooWeb.Router do
  use PhotozooWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", PhotozooWeb do
    pipe_through :api

    forward "graphql", Absinthe.Plug,
      schema: PhotozooWeb.Schema

    if Mix.env == :dev do
      forward "graphiql". Absinthe.Plug.GraphiQL,
        schema: Photozoo.Schema
    end
  end
end
