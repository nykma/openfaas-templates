defmodule OpenFaasService.MixProject do
  use Mix.Project

  def project do
    [
      app: :openfaas_service,
      version: "0.1.0",
      elixir: "~> 1.10",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger, :plug_cowboy],
      mod: {OpenFaasService, []}
    ]
  end

  defp deps do
    [
      {:plug_cowboy, "~> 2.3"},
      {:poison, "~> 4.0"},
    ]
  end
end
