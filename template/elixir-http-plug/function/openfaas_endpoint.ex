defmodule WebServer.OpenFaas.Endpoint do
  use Plug.Router

  plug(Plug.Logger)
  plug(:match)
  plug(Plug.Parsers, parsers: [:json], json_decoder: Poison)
  plug(:dispatch)

  get "/ping" do
    send_resp(conn, 200, "pong!")
  end

  post "/example" do
    {status, resp_body} =
      case conn.body_params do
        %{"data" => data} -> {200, process(data)}
        _ -> {422, missing_data()}
      end

    send_resp(conn, status, resp_body)
  end

  defp process(data) when is_list(data) do
    # Do some processing on a list of data
    Poison.encode!(%{response: "Received Data!"})
  end

  defp process(_) do
    # If we can't process anything, let them know :)
    Poison.encode!(%{response: "Please Send Some Data!"})
  end

  defp missing_data do
    Poison.encode!(%{error: "Expected Payload: { 'events': [...] }"})
  end

  match _ do
    send_resp(conn, 404, "oops... Nothing here :(")
  end
end
