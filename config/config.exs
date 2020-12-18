# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :svg_events_on_ios,
  ecto_repos: [SvgEventsOnIos.Repo]

# Configures the endpoint
config :svg_events_on_ios, SvgEventsOnIosWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "l2da1Y5EkHZEmx/d4foqzn7pO2U2KGGfzLiD0+nuXCG/pQORD3fsjWXeSVMf+6Ie",
  render_errors: [view: SvgEventsOnIosWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: SvgEventsOnIos.PubSub,
  live_view: [signing_salt: "apE1HWHM"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
