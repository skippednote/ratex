defmodule Ratex.Mixfile do
  use Mix.Project

  def project do
    [app: :ratex,
     version: "0.1.0",
     elixir: "~> 1.4",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps()]
  end

  def application do
    [extra_applications: [:logger],
     mod: {Ratex.Application, []}]
  end

  defp deps do
    [
      {:postgrex, "~> 0.13.0"},
      {:ecto, "~> 2.1"},
      {:httpoison , "~> 0.10.0"},
      {:poison, "~> 3.0.0"}
    ]
  end
end
