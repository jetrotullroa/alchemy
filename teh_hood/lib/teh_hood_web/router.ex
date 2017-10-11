defmodule TehHoodWeb.Router do
  use TehHoodWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/" do
    pipe_through :api

    forward "/graphiql", Absinthe.Plug.GraphiQL,
      schema: TehHoodWeb.Schema,
      interface: :simple,
      context: %{pubsub: TehHoodWeb.Endpoint}
  end
end
