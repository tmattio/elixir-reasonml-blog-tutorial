# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :blog_api,
  ecto_repos: [BlogApi.Repo],
  generators: [binary_id: true]

# Configures the endpoint
config :blog_api, BlogApiWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "I6agedhvcUhnN0B4yk6Guty73gwsdWrM/yqmcwGRvk4ArCcNZwDLPciqpfGTay1v",
  render_errors: [view: BlogApiWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: BlogApi.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Guardian
config :blog_api, BlogApiWeb.Auth.GuardianSerializer,
  issuer: "BlogApi",
  secret_key: "MDLMflIpKod5YCnkdiY7C4E3ki2rgcAAMwfBl0+vyC5uqJNgoibfQmAh7J3uZWVK",
  # optional
  allowed_algos: ["HS256"],
  ttl: {30, :days},
  allowed_drift: 2000,
  verify_issuer: true

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
