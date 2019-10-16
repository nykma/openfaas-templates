defmodule Cli do
  require Logger

  @eof "No input data supplied"

  def main(_args) do
    :stdio
    |> IO.read(:all)
    |> handle_input()
    |> deliver_output()
  end

  defp handle_input(:eof) do
    Logger.error(fn -> @eof end)
    @eof
  end

  defp handle_input({:error, reason}) do
    err = "Error #{reason} occurred"
    Logger.error(fn -> err end)
    err
  end

  defp handle_input(input) do
    Handler.handle(input)
  end

  defp deliver_output(resp) do
    IO.write(:stdio, resp)
  end
end
