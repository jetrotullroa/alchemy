# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :photozoo,
  ecto_repos: [Photozoo.Repo]

# Configures the endpoint
config :photozoo, PhotozooWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "y7XStW3K1BFGQV+h0Ejyp93xxnifl7ti2tPX7cgqEwQtwzL/sH/G6JcwnA+YLy9q",
  render_errors: [view: PhotozooWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: Photozoo.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
