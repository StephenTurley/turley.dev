# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :turley_dev,
  ecto_repos: [TurleyDev.Repo]

# Configures the endpoint
config :turley_dev, TurleyDevWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "GIhgy7QnYcAug5DYFdIhgQY4yF5xxhxrHiW/jIMmaGfrWcGLtozMtd65KV2RAtbh",
  render_errors: [view: TurleyDevWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: TurleyDev.PubSub,
  live_view: [signing_salt: "3Ny9AUPQ"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
