# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

config :ratex, Ratex.GetData,
  api_key: "537939575a12c1f137db1183c44efc02",
  api_url: "https://data.gov.in/api/datastore/resource.json?resource_id=9ef84268-d588-465a-a308-a864a43d0070"

config :ratex, Ratex.Repo,
  adapter: Ecto.Adapters.Postgres,
  database: "ratex_repo",
  username: "postgres",
  password: "postgres",
  hostname: "localhost"


config :ratex, ecto_repos: [Ratex.Repo]
