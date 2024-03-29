defmodule Sample.Mixfile do
  use Mix.Project

  def project do
    [
      app: :sample,
      version: "0.0.1",
      elixir: "~> 1.2",
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env == :prod,
      escript: [ main_module: Sample ],
      deps: deps
    ]
  end

  def application do
    [
      applications: [
        :logger,
        :httpotion,
        :poison
      ]
    ]
  end

  defp deps do
    [
      {:dogma, "~> 0.1", only: :dev},
      {:httpotion, "~> 3.0.0"},
      {:poison, "~> 2.0"}
    ]
  end
end
