import Config
config :openfaas_service, :port, System.get_env("HTTP_PORT")

config :logger,
  level: :warn,
  truncate: 4096
