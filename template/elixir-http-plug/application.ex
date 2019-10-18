defmodule WebServer.Application do
  use Application

  def start(_type, _args) do
    children = [
      Plug.Cowboy.child_spec(
        scheme: :http,
        plug: WebServer.OpenFaas.Endpoint,
        options: [port: Application.get_env(:web_server, :port) |> get_port()]
      )
    ]

    opts = [strategy: :one_for_one, name: WebServer.OpenFaas.Supervisor]
    Supervisor.start_link(children, opts)
  end

  defp get_port(nil), do: 4001
  defp get_port(port) when is_binary(port), do: String.to_integer(port)
end
