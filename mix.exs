defmodule Modulecopy.MixProject do
  use Mix.Project

  # use "bump_ex messagel" - command instead
  @version "1.2.3"

  def project do
    [
      app: :modulecopy,
      version: @version,
      elixir: "~> 1.10",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      escript: [main_module: Modulecopy.CLI]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:quick_alias, github: "werkzeugh/quick_alias", branch: "master"}

      # {:google_api_calendar, "~> 0.15"},
      # {:goth, "~> 1.2.0"},
      # {:tz, "~> 0.10.0"}
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
    ]
  end
end
