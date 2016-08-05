defmodule Iland.Mixfile do
  use Mix.Project

  def project do
    [app: :iland,
     description: "Elixir SDK for the iland cloud api (https://api.ilandcloud.com)",
     version: "0.1.0",
     elixir: "~> 1.3",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     name: "Iland Cloud Elixir SDK",
     source_url: "https://github.com/ilanddev/elixir-sdk",
     package: package(),
     deps: deps()]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: [:logger, :httpoison, :timex],
     mod: {Iland, []}]
  end

  defp package do
    [
      name: :iland,
      maintainers: ["Brett Snyder"],
      licenses: ["BSD"],
      links: %{"Github" => "https://github.com/ilanddev/elixir-sdk"}
    ]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [{:httpoison, "~> 0.9.0"},
     {:poison, "~> 2.0"},
     {:timex, "~> 3.0"}]
  end

end
