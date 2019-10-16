defmodule Cli.MixProject do
  use Mix.Project

  def project do
    [
      app: :cli,
      version: "0.1.0",
      elixir: "~> 1.9",
      start_permanent: Mix.env() == :prod,
      escript: [main_module: Cli, name: :elixir_function]
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end
end
