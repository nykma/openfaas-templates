import Config
config :web_server, :port, System.get_env("HTTP_PORT")

config :logger,
  level: :warn,
  truncate: 4096
