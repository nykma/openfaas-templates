defmodule OpenFaasService do
  use Application

  def start(_type, _args) do
    children = [
      Plug.Cowboy.child_spec(
        scheme: :http,
        plug: OpenFaasHandler,
        options: [port: Application.get_env(:openfaas_service, :port) |> get_port()]
      )
    ]

    opts = [strategy: :one_for_one, name: OpenFaasSupervisor]
    Supervisor.start_link(children, opts)
  end

  defp get_port(nil), do: 4001
  defp get_port(port) when is_binary(port), do: String.to_integer(port)
end
