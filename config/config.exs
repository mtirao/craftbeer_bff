# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :craftbeer_bff,
  ecto_repos: [CraftbeerBff.Repo]

# Configures the endpoint
config :craftbeer_bff, CraftbeerBffWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "HzEprsHD2Rmd728fmjJQLdqtnkjcX65DUfxz0GdjUxWipMTlOVbBozwv4T0MPKvY",
  render_errors: [view: CraftbeerBffWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: CraftbeerBff.PubSub,
  live_view: [signing_salt: "bcWIhqv8"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
